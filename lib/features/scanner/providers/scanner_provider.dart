import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../data/gmail_service.dart';
import '../data/email_parser.dart';
import '../data/subscription_detector.dart';
import '../domain/parsed_email.dart';
import '../domain/scan_progress.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../database/app_database.dart';
import '../../../core/constants.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final gmailServiceProvider = Provider<GmailService>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return GmailService(authRepo);
});

final emailParserProvider = Provider<EmailParser>((ref) {
  return const EmailParser();
});

final subscriptionDetectorProvider = Provider<SubscriptionDetector>((ref) {
  return SubscriptionDetector(ref.watch(databaseProvider));
});

final scannerProvider =
    StateNotifierProvider<ScannerNotifier, ScanProgress>((ref) {
  return ScannerNotifier(
    ref.watch(gmailServiceProvider),
    ref.watch(emailParserProvider),
    ref.watch(subscriptionDetectorProvider),
    ref.watch(databaseProvider),
  );
});

class ScannerNotifier extends StateNotifier<ScanProgress> {
  final GmailService _gmailService;
  final EmailParser _emailParser;
  final SubscriptionDetector _detector;
  final AppDatabase _db;

  ScannerNotifier(
    this._gmailService,
    this._emailParser,
    this._detector,
    this._db,
  ) : super(const ScanProgress());

  /// Run a full scan using all query strategies
  Future<void> startScan({int yearsBack = 2}) async {
    if (state.isScanning) return;

    _gmailService.reset();
    state = const ScanProgress(isScanning: true);

    try {
      final afterDate = yearsBack > 0
          ? DateTime.now()
              .subtract(Duration(days: yearsBack * 365))
              .toIso8601String()
              .substring(0, 10)
              .replaceAll('-', '/')
          : null;

      // Collect all message IDs from all queries
      final allIds = <String>{};

      final queries = [
        AppConstants.querySubjects,
        AppConstants.queryKnownSenders,
        AppConstants.queryPaymentSubjects,
      ];

      for (int i = 0; i < queries.length; i++) {
        if (!state.isScanning) return; // cancelled

        state = state.copyWith(
            currentQuery: 'Running query ${i + 1} of ${queries.length}...');

        final ids = await _gmailService.listMessageIds(
          query: queries[i],
          afterDate: afterDate,
          onPageFetched: (est) {
            state = state.copyWith(totalEmails: allIds.length + est);
          },
        );
        allIds.addAll(ids);
      }

      // Remove already-processed message IDs
      final newIds = <String>[];
      for (final id in allIds) {
        final exists = await _db.paymentDao.existsByMessageId(id);
        if (!exists) newIds.add(id);
      }

      state = state.copyWith(
        totalEmails: newIds.length,
        processedEmails: 0,
        currentQuery: 'Fetching and parsing emails...',
      );

      // Process emails in batches
      const batchSize = 20;
      final parsedBatch = <ParsedEmail>[];
      int totalSubscriptions = 0;
      int totalPayments = 0;

      for (int i = 0; i < newIds.length; i++) {
        if (!state.isScanning) return; // cancelled

        final message = await _gmailService.getMessage(newIds[i]);
        if (message != null) {
          final parsed = _emailParser.parse(message);
          if (parsed != null && parsed.hasAmount) {
            parsedBatch.add(parsed);
          }
        }

        state = state.copyWith(processedEmails: i + 1);

        // Process batch when full or at end
        if (parsedBatch.length >= batchSize || i == newIds.length - 1) {
          if (parsedBatch.isNotEmpty) {
            final result = await _detector.processEmails(parsedBatch);
            totalSubscriptions += result.subscriptions;
            totalPayments += result.payments;

            // Update services found list
            final services = <String>{...state.servicesFound};
            for (final p in parsedBatch) {
              if (p.serviceName != null) services.add(p.serviceName!);
            }

            state = state.copyWith(
              subscriptionsFound: totalSubscriptions,
              paymentsFound: totalPayments,
              servicesFound: services.toList(),
            );

            parsedBatch.clear();
          }
        }
      }

      // Record scan metadata
      await _db.scanDao.insertScan(
        ScanMetadataCompanion.insert(
          scanDate: DateTime.now(),
          emailsScanned: newIds.length,
          subscriptionsFound: totalSubscriptions,
          paymentsFound: totalPayments,
          lastMessageId: Value(newIds.isNotEmpty ? newIds.first : null),
        ),
      );

      state = state.copyWith(
        isScanning: false,
        isComplete: true,
        currentQuery: null,
      );
    } catch (e) {
      state = state.copyWith(
        isScanning: false,
        error: 'Scan failed: ${e.toString()}',
      );
    }
  }

  /// Incremental scan: only fetch emails newer than last scan
  Future<void> incrementalScan() async {
    final lastScan = await _db.scanDao.getLastScan();
    if (lastScan != null) {
      // Calculate how far back to look based on last scan
      final daysSinceLastScan =
          DateTime.now().difference(lastScan.scanDate).inDays;
      final yearsBack =
          (daysSinceLastScan / 365).ceil().clamp(1, 10);
      await startScan(yearsBack: yearsBack);
    } else {
      await startScan(yearsBack: 2);
    }
  }

  void cancelScan() {
    _gmailService.cancel();
    state = state.copyWith(isScanning: false, currentQuery: null);
  }

  void resetProgress() {
    state = const ScanProgress();
  }
}
