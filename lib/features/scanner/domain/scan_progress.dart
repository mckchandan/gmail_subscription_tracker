import 'package:flutter/foundation.dart';

@immutable
class ScanProgress {
  final bool isScanning;
  final int totalEmails;
  final int processedEmails;
  final int subscriptionsFound;
  final int paymentsFound;
  final List<String> servicesFound;
  final String? currentQuery;
  final String? error;
  final bool isComplete;

  const ScanProgress({
    this.isScanning = false,
    this.totalEmails = 0,
    this.processedEmails = 0,
    this.subscriptionsFound = 0,
    this.paymentsFound = 0,
    this.servicesFound = const [],
    this.currentQuery,
    this.error,
    this.isComplete = false,
  });

  double get progressPercent =>
      totalEmails > 0 ? processedEmails / totalEmails : 0;

  ScanProgress copyWith({
    bool? isScanning,
    int? totalEmails,
    int? processedEmails,
    int? subscriptionsFound,
    int? paymentsFound,
    List<String>? servicesFound,
    String? currentQuery,
    String? error,
    bool? isComplete,
  }) => ScanProgress(
    isScanning: isScanning ?? this.isScanning,
    totalEmails: totalEmails ?? this.totalEmails,
    processedEmails: processedEmails ?? this.processedEmails,
    subscriptionsFound: subscriptionsFound ?? this.subscriptionsFound,
    paymentsFound: paymentsFound ?? this.paymentsFound,
    servicesFound: servicesFound ?? this.servicesFound,
    currentQuery: currentQuery ?? this.currentQuery,
    error: error,
    isComplete: isComplete ?? this.isComplete,
  );
}
