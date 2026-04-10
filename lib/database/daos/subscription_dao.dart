import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/subscriptions_table.dart';

part 'subscription_dao.g.dart';

@DriftAccessor(tables: [Subscriptions])
class SubscriptionDao extends DatabaseAccessor<AppDatabase>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(super.db);

  Future<List<Subscription>> getAllSubscriptions() =>
      select(subscriptions).get();

  Stream<List<Subscription>> watchAllSubscriptions() =>
      select(subscriptions).watch();

  Future<List<Subscription>> getActiveSubscriptions() =>
      (select(subscriptions)..where((t) => t.isActive.equals(true))).get();

  Stream<List<Subscription>> watchActiveSubscriptions() =>
      (select(subscriptions)..where((t) => t.isActive.equals(true))).watch();

  Future<Subscription?> getByDomain(String domain) => (select(
    subscriptions,
  )..where((t) => t.senderDomain.equals(domain))).getSingleOrNull();

  Future<Subscription?> getById(int id) =>
      (select(subscriptions)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertSubscription(SubscriptionsCompanion entry) =>
      into(subscriptions).insert(entry);

  Future<bool> updateSubscription(Subscription entry) =>
      update(subscriptions).replace(entry);

  Future<int> deleteSubscription(int id) =>
      (delete(subscriptions)..where((t) => t.id.equals(id))).go();

  Future<void> toggleActive(int id, bool isActive) =>
      (update(subscriptions)..where((t) => t.id.equals(id))).write(
        SubscriptionsCompanion(isActive: Value(isActive)),
      );

  Future<void> updateLastSeen(int id, DateTime date) =>
      (update(subscriptions)..where((t) => t.id.equals(id))).write(
        SubscriptionsCompanion(lastSeenDate: Value(date)),
      );

  Future<void> updateTypicalAmount(int id, double amount) =>
      (update(subscriptions)..where((t) => t.id.equals(id))).write(
        SubscriptionsCompanion(typicalAmount: Value(amount)),
      );

  Future<int> deleteAll() => delete(subscriptions).go();
}
