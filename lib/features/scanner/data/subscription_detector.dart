import 'package:drift/drift.dart';
import '../domain/parsed_email.dart';
import '../../../database/app_database.dart';
import '../../../core/utils/date_utils.dart';

/// Analyzes parsed emails, groups them into subscriptions,
/// detects billing cycles, and stores results in the database.
class SubscriptionDetector {
  final AppDatabase _db;

  SubscriptionDetector(this._db);

  /// Process a batch of parsed emails into subscriptions and payments.
  /// Returns the count of new payments inserted.
  Future<({int subscriptions, int payments})> processEmails(
    List<ParsedEmail> parsedEmails,
  ) async {
    // Group emails by sender domain
    final groups = <String, List<ParsedEmail>>{};
    for (final email in parsedEmails) {
      if (email.hasAmount) {
        groups.putIfAbsent(email.senderDomain, () => []).add(email);
      }
    }

    int newSubscriptions = 0;
    int newPayments = 0;

    for (final entry in groups.entries) {
      final domain = entry.key;
      final emails = entry.value;

      // Get or create subscription for this domain
      var subscription = await _db.subscriptionDao.getByDomain(domain);
      int subscriptionId;

      if (subscription == null) {
        // Create new subscription
        final representative = emails.first;
        final dates = emails.map((e) => e.paymentDate ?? e.emailDate).toList()
          ..sort();

        // Determine billing cycle from payment intervals
        final billingCycle = _detectBillingCycle(dates);

        // Calculate typical (most common) amount
        final typicalAmount = _calculateTypicalAmount(emails);

        subscriptionId = await _db.subscriptionDao.insertSubscription(
          SubscriptionsCompanion.insert(
            serviceName: representative.serviceName ?? domain,
            serviceCategory: Value(representative.serviceCategory),
            senderEmail: representative.senderEmail,
            senderDomain: domain,
            typicalAmount: typicalAmount,
            currency: Value(representative.currency ?? 'USD'),
            billingCycle: Value(billingCycle),
            firstSeenDate: dates.first,
            lastSeenDate: dates.last,
            isActive: Value(_isActive(dates.last, billingCycle)),
          ),
        );
        newSubscriptions++;
      } else {
        subscriptionId = subscription.id;

        // Update existing subscription's lastSeenDate
        final latestDate = emails
            .map((e) => e.paymentDate ?? e.emailDate)
            .reduce((a, b) => a.isAfter(b) ? a : b);

        if (latestDate.isAfter(subscription.lastSeenDate)) {
          await _db.subscriptionDao.updateLastSeen(subscriptionId, latestDate);
        }

        // Recalculate typical amount
        final allPayments = await _db.paymentDao.getPaymentsForSubscription(
          subscriptionId,
        );
        final allAmounts = [
          ...allPayments.map((p) => p.amount),
          ...emails.map((e) => e.amount!),
        ];
        final typicalAmount = _mode(allAmounts);
        await _db.subscriptionDao.updateTypicalAmount(
          subscriptionId,
          typicalAmount,
        );

        // Update active status
        final allDates = [
          ...allPayments.map((p) => p.paymentDate),
          ...emails.map((e) => e.paymentDate ?? e.emailDate),
        ]..sort();
        final billingCycle = _detectBillingCycle(allDates);
        final isActive = _isActive(allDates.last, billingCycle);
        await _db.subscriptionDao.toggleActive(subscriptionId, isActive);
      }

      // Insert payments, skipping duplicates
      for (final email in emails) {
        // Skip if message already processed
        final exists = await _db.paymentDao.existsByMessageId(email.messageId);
        if (exists) continue;

        // Skip if duplicate (same sub + date + amount)
        final isDup = await _db.paymentDao.isDuplicate(
          subscriptionId,
          email.paymentDate ?? email.emailDate,
          email.amount!,
        );
        if (isDup) continue;

        await _db.paymentDao.insertPayment(
          PaymentsCompanion.insert(
            subscriptionId: subscriptionId,
            amount: email.amount!,
            currency: email.currency ?? 'USD',
            paymentDate: email.paymentDate ?? email.emailDate,
            gmailMessageId: email.messageId,
            emailSubject: Value(email.subject),
            confidence: Value(email.confidence),
          ),
        );
        newPayments++;
      }
    }

    return (subscriptions: newSubscriptions, payments: newPayments);
  }

  /// Detect billing cycle from a sorted list of payment dates
  String _detectBillingCycle(List<DateTime> dates) {
    final avgDays = AppDateUtils.averageIntervalDays(dates);
    if (avgDays == null) return 'monthly'; // default for single payment
    return AppDateUtils.billingCycleFromInterval(avgDays);
  }

  /// Determine if subscription is likely still active
  bool _isActive(DateTime lastPaymentDate, String billingCycle) {
    final now = DateTime.now();
    final daysSinceLastPayment = now.difference(lastPaymentDate).inDays;

    final thresholdDays = switch (billingCycle) {
      'weekly' => 14,
      'monthly' => 45,
      'quarterly' => 135,
      'annual' => 548,
      _ => 45,
    };

    return daysSinceLastPayment <= thresholdDays;
  }

  /// Calculate the most common amount (mode) from parsed emails
  double _calculateTypicalAmount(List<ParsedEmail> emails) {
    final amounts = emails
        .where((e) => e.hasAmount)
        .map((e) => e.amount!)
        .toList();
    return _mode(amounts);
  }

  /// Find the mode (most common value) in a list of doubles
  double _mode(List<double> values) {
    if (values.isEmpty) return 0;

    // Round to 2 decimal places for comparison
    final freq = <String, int>{};
    for (final v in values) {
      final key = v.toStringAsFixed(2);
      freq[key] = (freq[key] ?? 0) + 1;
    }

    final mostCommonKey = freq.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
    return double.parse(mostCommonKey);
  }
}
