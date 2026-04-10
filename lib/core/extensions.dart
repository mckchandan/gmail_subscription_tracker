import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get formatted => DateFormat('MMM d, yyyy').format(this);

  String get formattedShort => DateFormat('MMM d').format(this);

  String get formattedWithTime => DateFormat('MMM d, yyyy h:mm a').format(this);

  String get monthYear => DateFormat('MMM yyyy').format(this);

  String get yearMonthDay => DateFormat('yyyy/MM/dd').format(this);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  int daysBetween(DateTime other) => difference(other).inDays.abs();

  String durationSince() {
    final now = DateTime.now();
    final diff = now.difference(this);

    final years = diff.inDays ~/ 365;
    final months = (diff.inDays % 365) ~/ 30;

    if (years > 0 && months > 0) {
      return '$years year${years > 1 ? 's' : ''}, $months month${months > 1 ? 's' : ''}';
    } else if (years > 0) {
      return '$years year${years > 1 ? 's' : ''}';
    } else if (months > 0) {
      return '$months month${months > 1 ? 's' : ''}';
    } else {
      return '${diff.inDays} day${diff.inDays != 1 ? 's' : ''}';
    }
  }
}

extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ').map((w) => w.capitalize).join(' ');

  /// Extract domain from email address
  String? get emailDomain {
    final atIndex = indexOf('@');
    if (atIndex < 0 || atIndex >= length - 1) return null;
    return substring(atIndex + 1).toLowerCase();
  }
}

extension NumExtensions on num {
  String toCurrency(String currency) {
    final symbols = {
      'USD': '\$',
      'INR': '₹',
      'EUR': '€',
      'GBP': '£',
      'CAD': 'CA\$',
      'AUD': 'A\$',
      'JPY': '¥',
    };
    final symbol = symbols[currency.toUpperCase()] ?? currency;
    if (currency.toUpperCase() == 'JPY') {
      return '$symbol${toInt()}';
    }
    return '$symbol${toStringAsFixed(2)}';
  }

  /// Convert amount to monthly equivalent
  double toMonthly(String billingCycle) {
    switch (billingCycle.toLowerCase()) {
      case 'weekly':
        return toDouble() * 52 / 12;
      case 'annual':
      case 'yearly':
        return toDouble() / 12;
      case 'monthly':
      default:
        return toDouble();
    }
  }
}
