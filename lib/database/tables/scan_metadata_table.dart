import 'package:drift/drift.dart';

class ScanMetadata extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get scanDate => dateTime()();
  IntColumn get emailsScanned => integer()();
  IntColumn get subscriptionsFound => integer()();
  IntColumn get paymentsFound => integer()();
  TextColumn get lastMessageId => text().nullable()();
}
