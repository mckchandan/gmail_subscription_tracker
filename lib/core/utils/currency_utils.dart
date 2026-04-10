import 'package:intl/intl.dart';

class CurrencyUtils {
  CurrencyUtils._();

  static const Map<String, String> currencySymbols = {
    'USD': '\$',
    'INR': '₹',
    'EUR': '€',
    'GBP': '£',
    'CAD': 'CA\$',
    'AUD': 'A\$',
    'JPY': '¥',
  };

  static const List<String> supportedCurrencies = [
    'USD',
    'INR',
    'EUR',
    'GBP',
    'CAD',
    'AUD',
    'JPY',
  ];

  static String format(double amount, String currency) {
    final symbol = currencySymbols[currency.toUpperCase()] ?? currency;
    if (currency.toUpperCase() == 'JPY') {
      return '$symbol${NumberFormat('#,##0').format(amount.toInt())}';
    }
    return '$symbol${NumberFormat('#,##0.00').format(amount)}';
  }

  static String formatCompact(double amount, String currency) {
    final symbol = currencySymbols[currency.toUpperCase()] ?? currency;
    if (amount >= 1000) {
      return '$symbol${NumberFormat.compact().format(amount)}';
    }
    return format(amount, currency);
  }

  /// Detect currency from a text string
  static String? detectCurrency(String text) {
    if (RegExp(r'\$\s*[\d,]+\.?\d*').hasMatch(text) ||
        text.toUpperCase().contains('USD')) {
      return 'USD';
    }
    if (RegExp(r'₹\s*[\d,]+\.?\d*').hasMatch(text) ||
        text.toUpperCase().contains('INR') ||
        text.contains('Rs.') ||
        text.contains('Rs ')) {
      return 'INR';
    }
    if (RegExp(r'€\s*[\d,]+\.?\d*').hasMatch(text) ||
        text.toUpperCase().contains('EUR')) {
      return 'EUR';
    }
    if (RegExp(r'£\s*[\d,]+\.?\d*').hasMatch(text) ||
        text.toUpperCase().contains('GBP')) {
      return 'GBP';
    }
    if (text.toUpperCase().contains('CAD') || text.contains('CA\$')) {
      return 'CAD';
    }
    if (text.toUpperCase().contains('AUD') || text.contains('A\$')) {
      return 'AUD';
    }
    if (RegExp(r'¥\s*[\d,]+').hasMatch(text) ||
        text.toUpperCase().contains('JPY')) {
      return 'JPY';
    }
    return null;
  }
}
