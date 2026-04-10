import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import '../../auth/data/auth_repository.dart';
import '../../../core/constants.dart';

/// Wrapper around the Gmail API with rate limiting and pagination support
class GmailService {
  final AuthRepository _authRepository;
  gmail.GmailApi? _api;

  // Rate limiting
  final _requestTimestamps = <DateTime>[];
  bool _cancelled = false;

  GmailService(this._authRepository);

  Future<gmail.GmailApi> _getApi() async {
    _api ??= await _authRepository.getGmailApi();
    return _api!;
  }

  void cancel() {
    _cancelled = true;
  }

  void reset() {
    _cancelled = false;
    _api = null;
  }

  /// Rate limit: wait if needed to stay under maxRequestsPerSecond
  Future<void> _rateLimit() async {
    final now = DateTime.now();
    _requestTimestamps.removeWhere(
      (t) => now.difference(t).inMilliseconds > 1000,
    );

    if (_requestTimestamps.length >= AppConstants.maxRequestsPerSecond) {
      final oldestInWindow = _requestTimestamps.first;
      final waitMs = 1000 - now.difference(oldestInWindow).inMilliseconds;
      if (waitMs > 0) {
        await Future.delayed(Duration(milliseconds: waitMs));
      }
    }
    _requestTimestamps.add(DateTime.now());
  }

  /// Fetch message IDs matching a query, handling pagination.
  /// [afterDate] in format YYYY/MM/DD for incremental scans.
  /// [onPageFetched] reports total messages estimated so far.
  Future<List<String>> listMessageIds({
    required String query,
    String? afterDate,
    void Function(int estimatedTotal)? onPageFetched,
  }) async {
    final api = await _getApi();
    final fullQuery = afterDate != null ? '$query after:$afterDate' : query;

    final ids = <String>[];
    String? pageToken;

    do {
      if (_cancelled) return ids;

      await _rateLimit();

      gmail.ListMessagesResponse response;
      try {
        response = await _retryWithBackoff(
          () => api.users.messages.list(
            'me',
            q: fullQuery,
            pageToken: pageToken,
            maxResults: 500,
          ),
        );
      } catch (e) {
        debugPrint('Error listing messages: $e');
        break;
      }

      final messages = response.messages ?? [];
      ids.addAll(messages.map((m) => m.id!));

      onPageFetched?.call(response.resultSizeEstimate ?? ids.length);

      pageToken = response.nextPageToken;
    } while (pageToken != null);

    return ids;
  }

  /// Fetch a single message with full format (headers + body)
  Future<gmail.Message?> getMessage(String messageId) async {
    if (_cancelled) return null;

    final api = await _getApi();
    await _rateLimit();

    try {
      return await _retryWithBackoff(
        () => api.users.messages.get('me', messageId, format: 'full'),
      );
    } catch (e) {
      debugPrint('Error fetching message $messageId: $e');
      return null;
    }
  }

  /// Extract headers from a Gmail message
  static Map<String, String> extractHeaders(gmail.Message message) {
    final headers = <String, String>{};
    final payload = message.payload;
    if (payload?.headers != null) {
      for (final header in payload!.headers!) {
        if (header.name != null && header.value != null) {
          headers[header.name!.toLowerCase()] = header.value!;
        }
      }
    }
    return headers;
  }

  /// Extract the text body from a Gmail message (decoded from base64)
  static String extractBody(gmail.Message message) {
    final payload = message.payload;
    if (payload == null) return '';

    // Try to get text/plain body first, then text/html
    final textBody = _extractPartBody(payload, 'text/plain');
    if (textBody.isNotEmpty) return textBody;

    final htmlBody = _extractPartBody(payload, 'text/html');
    return htmlBody;
  }

  static String _extractPartBody(gmail.MessagePart part, String mimeType) {
    // Check this part directly
    if (part.mimeType == mimeType && part.body?.data != null) {
      return _decodeBase64Url(part.body!.data!);
    }

    // Check sub-parts recursively
    if (part.parts != null) {
      for (final subPart in part.parts!) {
        final result = _extractPartBody(subPart, mimeType);
        if (result.isNotEmpty) return result;
      }
    }

    return '';
  }

  static String _decodeBase64Url(String encoded) {
    try {
      // Gmail uses URL-safe base64, replace URL-safe chars
      final normalized = encoded.replaceAll('-', '+').replaceAll('_', '/');
      return utf8.decode(base64.decode(normalized));
    } catch (e) {
      return '';
    }
  }

  /// Retry with exponential backoff for transient errors
  Future<T> _retryWithBackoff<T>(Future<T> Function() fn) async {
    int retries = 0;
    while (true) {
      try {
        return await fn();
      } catch (e) {
        retries++;
        if (retries > AppConstants.maxRetries) rethrow;

        // Check for rate limit errors (HTTP 429)
        final isRateLimit =
            e.toString().contains('429') ||
            e.toString().contains('rateLimitExceeded');
        if (!isRateLimit && retries > 2) rethrow;

        final delay = Duration(
          milliseconds: (1000 * (1 << retries)).clamp(1000, 32000),
        );
        debugPrint('Retrying in ${delay.inSeconds}s (attempt $retries)');
        await Future.delayed(delay);
      }
    }
  }
}
