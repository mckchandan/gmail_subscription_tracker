import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  /// Try to parse a date from various common formats found in emails
  static DateTime? tryParse(String text) {
    final formats = [
      'MMM d, yyyy', // Jan 15, 2024
      'MMMM d, yyyy', // January 15, 2024
      'MMM dd, yyyy', // Jan 05, 2024
      'MMMM dd, yyyy', // January 05, 2024
      'd MMM yyyy', // 15 Jan 2024
      'dd MMM yyyy', // 05 Jan 2024
      'd MMMM yyyy', // 15 January 2024
      'yyyy-MM-dd', // 2024-01-15
      'MM/dd/yyyy', // 01/15/2024
      'dd/MM/yyyy', // 15/01/2024
      'M/d/yyyy', // 1/5/2024
      'yyyy/MM/dd', // 2024/01/15
    ];

    for (final fmt in formats) {
      try {
        return DateFormat(fmt).parseStrict(text.trim());
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  /// Parse RFC 2822 date from email headers
  static DateTime? parseEmailDate(String dateStr) {
    try {
      // Remove timezone abbreviations like (PST), (EST) etc.
      final cleaned = dateStr
          .replaceAll(RegExp(r'\s*\([A-Z]{2,4}\)\s*$'), '')
          .trim();
      return DateFormat('EEE, d MMM yyyy HH:mm:ss Z').parse(cleaned);
    } catch (_) {
      try {
        return DateTime.parse(dateStr);
      } catch (_) {
        return null;
      }
    }
  }

  /// Get Gmail after: query parameter date string
  static String gmailAfterDate(int yearsBack) {
    final date = DateTime.now().subtract(Duration(days: yearsBack * 365));
    return DateFormat('yyyy/MM/dd').format(date);
  }

  /// Calculate average interval between dates in days
  static double? averageIntervalDays(List<DateTime> dates) {
    if (dates.length < 2) return null;

    final sorted = List<DateTime>.from(dates)..sort();
    double totalDays = 0;
    for (var i = 1; i < sorted.length; i++) {
      totalDays += sorted[i].difference(sorted[i - 1]).inDays;
    }
    return totalDays / (sorted.length - 1);
  }

  /// Determine billing cycle from average interval
  static String billingCycleFromInterval(double avgDays) {
    if (avgDays < 10) return 'weekly';
    if (avgDays < 45) return 'monthly';
    if (avgDays < 100) return 'quarterly';
    return 'annual';
  }
}
