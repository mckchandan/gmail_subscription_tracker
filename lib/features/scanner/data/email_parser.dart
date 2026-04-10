import 'package:flutter/foundation.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:html/parser.dart' as html_parser;
import '../domain/parsed_email.dart';
import 'known_senders.dart';
import 'gmail_service.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../core/utils/date_utils.dart';

/// Parses a Gmail message into structured subscription/payment data
class EmailParser {
  const EmailParser();

  ParsedEmail? parse(gmail.Message message) {
    try {
      final headers = GmailService.extractHeaders(message);
      final from = headers['from'] ?? '';
      final subject = headers['subject'] ?? '';
      final dateStr = headers['date'] ?? '';

      final senderEmail = _extractEmail(from);
      final senderDomain = _extractDomain(senderEmail);
      final senderDisplayName = _extractDisplayName(from);

      if (senderEmail.isEmpty || senderDomain.isEmpty) return null;

      final emailDate = AppDateUtils.parseEmailDate(dateStr) ?? DateTime.now();

      // Get email body text
      final rawBody = GmailService.extractBody(message);
      final bodyText = _stripHtml(rawBody);

      // Try known sender rules first
      final rule = findRuleForEmail(senderEmail);

      String? serviceName;
      String? category;
      double? amount;
      String? currency;
      DateTime? paymentDate;
      String confidence = 'low';

      if (rule != null) {
        // Known sender: use service-specific parsing
        serviceName = rule.serviceName;
        category = rule.category;

        // Try service-specific amount patterns first
        for (final pattern in rule.amountPatterns) {
          final match = pattern.firstMatch(bodyText);
          if (match != null) {
            amount = _parseAmountFromMatch(match.group(0)!);
            break;
          }
        }

        // Fall back to generic amount extraction
        amount ??= _extractAmount(bodyText);
        currency = _extractCurrency(bodyText) ?? 'USD';
        paymentDate = _extractPaymentDate(bodyText) ?? emailDate;
        confidence = amount != null ? 'high' : 'medium';
      } else {
        // Unknown sender: generic parsing
        serviceName = _extractServiceName(senderDisplayName, subject);
        amount = _extractAmount(bodyText);
        currency = _extractCurrency(bodyText) ?? 'USD';
        paymentDate = _extractPaymentDate(bodyText);

        // Confidence: high if all found, medium if some, low otherwise
        if (amount != null && serviceName != null) {
          confidence = 'medium';
        }
      }

      return ParsedEmail(
        messageId: message.id ?? '',
        senderEmail: senderEmail,
        senderDomain: senderDomain,
        senderDisplayName: senderDisplayName,
        subject: subject,
        emailDate: emailDate,
        serviceName: serviceName,
        serviceCategory: category,
        amount: amount,
        currency: currency,
        paymentDate: paymentDate ?? emailDate,
        confidence: confidence,
      );
    } catch (e) {
      debugPrint('Error parsing message ${message.id}: $e');
      return null;
    }
  }

  /// Extract email address from a From header like "Netflix <info@netflix.com>"
  String _extractEmail(String from) {
    final match = RegExp(r'<([^>]+)>').firstMatch(from);
    if (match != null) return match.group(1)!.trim().toLowerCase();
    // If no angle brackets, the whole thing might be the email
    if (from.contains('@')) return from.trim().toLowerCase();
    return '';
  }

  /// Extract domain from email
  String _extractDomain(String email) {
    final parts = email.split('@');
    return parts.length == 2 ? parts[1].toLowerCase() : '';
  }

  /// Extract display name from From header
  String? _extractDisplayName(String from) {
    final match = RegExp(r'^"?([^"<]+)"?\s*<').firstMatch(from);
    if (match != null) return match.group(1)!.trim();
    return null;
  }

  /// Strip HTML tags and decode entities to get plain text
  String _stripHtml(String html) {
    if (!html.contains('<')) return html;
    try {
      final doc = html_parser.parse(html);
      return doc.body?.text ?? html;
    } catch (_) {
      return html.replaceAll(RegExp(r'<[^>]+>'), ' ');
    }
  }

  /// Extract a monetary amount from text using multiple currency patterns
  double? _extractAmount(String text) {
    // Patterns ordered by specificity:
    // Total/Amount/Charged patterns (most reliable in payment emails)
    final totalPatterns = [
      RegExp(
        r'(?:total|amount|charged|charge|payment|price|cost|billed)\s*:?\s*[\$€£₹¥][\s]*([\d,]+\.?\d*)',
        caseSensitive: false,
      ),
      RegExp(r'[\$€£₹¥]\s*([\d,]+\.\d{2})'),
      RegExp(
        r'([\d,]+\.\d{2})\s*(?:USD|INR|EUR|GBP|CAD|AUD)',
        caseSensitive: false,
      ),
      RegExp(
        r'(?:USD|INR|EUR|GBP|CAD|AUD)\s*([\d,]+\.\d{2})',
        caseSensitive: false,
      ),
      RegExp(r'Rs\.?\s*([\d,]+\.?\d*)'),
    ];

    for (final pattern in totalPatterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        final parsed = _parseAmountFromMatch(match.group(1) ?? match.group(0)!);
        if (parsed != null && parsed > 0 && parsed < 100000) return parsed;
      }
    }
    return null;
  }

  /// Parse a numeric amount from a matched string like "$12.99" or "12,345.99"
  double? _parseAmountFromMatch(String text) {
    // Remove currency symbols and whitespace
    final cleaned = text.replaceAll(RegExp(r'[^\d.,]'), '').replaceAll(',', '');
    return double.tryParse(cleaned);
  }

  /// Detect currency from the email body text
  String? _extractCurrency(String text) {
    return CurrencyUtils.detectCurrency(text);
  }

  /// Try to find a specific payment date mentioned in the email body
  DateTime? _extractPaymentDate(String text) {
    // Look for date patterns near payment-related keywords
    final datePatterns = [
      RegExp(
        r'(?:date|on|charged on|payment date|billed on)\s*:?\s*(\w+ \d{1,2},?\s*\d{4})',
        caseSensitive: false,
      ),
      RegExp(r'(\d{1,2}/\d{1,2}/\d{4})'),
      RegExp(r'(\d{4}-\d{2}-\d{2})'),
      RegExp(r'(\w+ \d{1,2},?\s*\d{4})'),
    ];

    for (final pattern in datePatterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        final parsed = AppDateUtils.tryParse(match.group(1) ?? match.group(0)!);
        if (parsed != null) return parsed;
      }
    }
    return null;
  }

  /// Extract service name when not in known senders DB
  String? _extractServiceName(String? displayName, String subject) {
    // Try extracting from subject patterns like "Your Netflix receipt"
    final subjectPatterns = [
      RegExp(
        r'(?:your|from)\s+(\w+(?:\s+\w+)?)\s+(?:receipt|payment|invoice|subscription|billing|charge)',
        caseSensitive: false,
      ),
      RegExp(
        r'(\w+(?:\s+\w+)?)\s+(?:receipt|payment|invoice|subscription|billing|charge)',
        caseSensitive: false,
      ),
    ];

    for (final pattern in subjectPatterns) {
      final match = pattern.firstMatch(subject);
      if (match != null) {
        final name = match.group(1)!.trim();
        if (name.length > 1 && name.length < 40) return name;
      }
    }

    // Fall back to display name from sender
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }

    return null;
  }
}
