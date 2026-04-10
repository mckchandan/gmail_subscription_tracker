import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/scan_metadata_table.dart';

part 'scan_dao.g.dart';

@DriftAccessor(tables: [ScanMetadata])
class ScanDao extends DatabaseAccessor<AppDatabase> with _$ScanDaoMixin {
  ScanDao(super.db);

  Future<List<ScanMetadataData>> getAllScans() => (select(
    scanMetadata,
  )..orderBy([(t) => OrderingTerm.desc(t.scanDate)])).get();

  Future<ScanMetadataData?> getLastScan() =>
      (select(scanMetadata)
            ..orderBy([(t) => OrderingTerm.desc(t.scanDate)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertScan(ScanMetadataCompanion entry) =>
      into(scanMetadata).insert(entry);

  Future<int> deleteAll() => delete(scanMetadata).go();
}
