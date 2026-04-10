import 'package:drift/drift.dart';

class Subscriptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serviceName => text()();
  TextColumn get serviceCategory => text().nullable()();
  TextColumn get senderEmail => text()();
  TextColumn get senderDomain => text()();
  RealColumn get typicalAmount => real()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get billingCycle =>
      text().withDefault(const Constant('monthly'))();
  DateTimeColumn get firstSeenDate => dateTime()();
  DateTimeColumn get lastSeenDate => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get notes => text().nullable()();
}
