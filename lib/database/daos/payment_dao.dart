import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/payments_table.dart';
import '../tables/subscriptions_table.dart';

part 'payment_dao.g.dart';

@DriftAccessor(tables: [Payments, Subscriptions])
class PaymentDao extends DatabaseAccessor<AppDatabase> with _$PaymentDaoMixin {
  PaymentDao(super.db);

  Future<List<Payment>> getAllPayments() => (select(
    payments,
  )..orderBy([(t) => OrderingTerm.desc(t.paymentDate)])).get();

  Stream<List<Payment>> watchAllPayments() => (select(
    payments,
  )..orderBy([(t) => OrderingTerm.desc(t.paymentDate)])).watch();

  Future<List<Payment>> getPaymentsForSubscription(int subscriptionId) =>
      (select(payments)
            ..where((t) => t.subscriptionId.equals(subscriptionId))
            ..orderBy([(t) => OrderingTerm.desc(t.paymentDate)]))
          .get();

  Stream<List<Payment>> watchPaymentsForSubscription(int subscriptionId) =>
      (select(payments)
            ..where((t) => t.subscriptionId.equals(subscriptionId))
            ..orderBy([(t) => OrderingTerm.desc(t.paymentDate)]))
          .watch();

  Future<List<Payment>> getRecentPayments({int limit = 5}) =>
      (select(payments)
            ..orderBy([(t) => OrderingTerm.desc(t.paymentDate)])
            ..limit(limit))
          .get();

  Stream<List<Payment>> watchRecentPayments({int limit = 5}) =>
      (select(payments)
            ..orderBy([(t) => OrderingTerm.desc(t.paymentDate)])
            ..limit(limit))
          .watch();

  Future<bool> existsByMessageId(String messageId) async {
    final result = await (select(
      payments,
    )..where((t) => t.gmailMessageId.equals(messageId))).getSingleOrNull();
    return result != null;
  }

  Future<bool> isDuplicate(
    int subscriptionId,
    DateTime date,
    double amount,
  ) async {
    final results =
        await (select(payments)..where(
              (t) =>
                  t.subscriptionId.equals(subscriptionId) &
                  t.amount.equals(amount),
            ))
            .get();

    return results.any((p) => p.paymentDate.difference(date).inDays.abs() < 2);
  }

  Future<int> insertPayment(PaymentsCompanion entry) =>
      into(payments).insert(entry);

  Future<bool> updatePayment(Payment entry) => update(payments).replace(entry);

  Future<int> deletePayment(int id) =>
      (delete(payments)..where((t) => t.id.equals(id))).go();

  Future<int> deletePaymentsForSubscription(int subscriptionId) => (delete(
    payments,
  )..where((t) => t.subscriptionId.equals(subscriptionId))).go();

  Future<double> totalSpentForSubscription(int subscriptionId) async {
    final result = await (select(
      payments,
    )..where((t) => t.subscriptionId.equals(subscriptionId))).get();
    double total = 0;
    for (final p in result) {
      total += p.amount;
    }
    return total;
  }

  Future<double> totalSpentAllTime() async {
    final result = await select(payments).get();
    double total = 0;
    for (final p in result) {
      total += p.amount;
    }
    return total;
  }

  /// Get monthly spending totals for the last N months
  Future<Map<DateTime, double>> monthlySpending(int months) async {
    final cutoff = DateTime.now().subtract(Duration(days: months * 31));
    final result =
        await (select(payments)
              ..where((t) => t.paymentDate.isBiggerOrEqualValue(cutoff))
              ..orderBy([(t) => OrderingTerm.asc(t.paymentDate)]))
            .get();

    final map = <DateTime, double>{};
    for (final payment in result) {
      final monthKey = DateTime(
        payment.paymentDate.year,
        payment.paymentDate.month,
      );
      map[monthKey] = (map[monthKey] ?? 0) + payment.amount;
    }
    return map;
  }

  Future<int> deleteAll() => delete(payments).go();
}
