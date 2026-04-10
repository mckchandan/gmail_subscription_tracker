import 'package:flutter/foundation.dart';

/// Represents data extracted from a single email
@immutable
class ParsedEmail {
  final String messageId;
  final String senderEmail;
  final String senderDomain;
  final String? senderDisplayName;
  final String subject;
  final DateTime emailDate;
  final String? serviceName;
  final String? serviceCategory;
  final double? amount;
  final String? currency;
  final DateTime? paymentDate;
  final String confidence; // high, medium, low

  const ParsedEmail({
    required this.messageId,
    required this.senderEmail,
    required this.senderDomain,
    this.senderDisplayName,
    required this.subject,
    required this.emailDate,
    this.serviceName,
    this.serviceCategory,
    this.amount,
    this.currency,
    this.paymentDate,
    this.confidence = 'low',
  });

  bool get hasAmount => amount != null && amount! > 0;
  bool get hasServiceName => serviceName != null && serviceName!.isNotEmpty;

  ParsedEmail copyWith({
    String? serviceName,
    String? serviceCategory,
    double? amount,
    String? currency,
    DateTime? paymentDate,
    String? confidence,
  }) => ParsedEmail(
    messageId: messageId,
    senderEmail: senderEmail,
    senderDomain: senderDomain,
    senderDisplayName: senderDisplayName,
    subject: subject,
    emailDate: emailDate,
    serviceName: serviceName ?? this.serviceName,
    serviceCategory: serviceCategory ?? this.serviceCategory,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    paymentDate: paymentDate ?? this.paymentDate,
    confidence: confidence ?? this.confidence,
  );

  @override
  String toString() =>
      'ParsedEmail($serviceName, $amount $currency, $emailDate)';
}
