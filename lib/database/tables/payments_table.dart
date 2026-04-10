import 'package:drift/drift.dart';
import 'subscriptions_table.dart';

class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subscriptionId => integer().references(Subscriptions, #id)();
  RealColumn get amount => real()();
  TextColumn get currency => text()();
  DateTimeColumn get paymentDate => dateTime()();
  TextColumn get gmailMessageId => text()();
  TextColumn get emailSubject => text().nullable()();
  TextColumn get confidence => text().withDefault(const Constant('high'))();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
}
