import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/constants.dart';

class SettingsState {
  final int scanDateRangeYears; // 1, 2, 3, or -1 for all time
  final String autoScanFrequency; // manual, weekly, monthly
  final String primaryCurrency;
  final bool notificationsEnabled;

  const SettingsState({
    this.scanDateRangeYears = 2,
    this.autoScanFrequency = 'manual',
    this.primaryCurrency = 'USD',
    this.notificationsEnabled = false,
  });

  SettingsState copyWith({
    int? scanDateRangeYears,
    String? autoScanFrequency,
    String? primaryCurrency,
    bool? notificationsEnabled,
  }) => SettingsState(
    scanDateRangeYears: scanDateRangeYears ?? this.scanDateRangeYears,
    autoScanFrequency: autoScanFrequency ?? this.autoScanFrequency,
    primaryCurrency: primaryCurrency ?? this.primaryCurrency,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
  );
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier();
  },
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  final _storage = const FlutterSecureStorage();

  SettingsNotifier() : super(const SettingsState()) {
    _load();
  }

  Future<void> _load() async {
    final range = await _storage.read(key: AppConstants.keyScanDateRange);
    final freq = await _storage.read(key: AppConstants.keyAutoScanFrequency);
    final currency = await _storage.read(key: AppConstants.keyPrimaryCurrency);
    final notif = await _storage.read(
      key: AppConstants.keyNotificationsEnabled,
    );

    state = SettingsState(
      scanDateRangeYears: range != null ? int.tryParse(range) ?? 2 : 2,
      autoScanFrequency: freq ?? 'manual',
      primaryCurrency: currency ?? 'USD',
      notificationsEnabled: notif == 'true',
    );
  }

  Future<void> setScanDateRange(int years) async {
    state = state.copyWith(scanDateRangeYears: years);
    await _storage.write(
      key: AppConstants.keyScanDateRange,
      value: years.toString(),
    );
  }

  Future<void> setAutoScanFrequency(String freq) async {
    state = state.copyWith(autoScanFrequency: freq);
    await _storage.write(key: AppConstants.keyAutoScanFrequency, value: freq);
  }

  Future<void> setPrimaryCurrency(String currency) async {
    state = state.copyWith(primaryCurrency: currency);
    await _storage.write(key: AppConstants.keyPrimaryCurrency, value: currency);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    state = state.copyWith(notificationsEnabled: enabled);
    await _storage.write(
      key: AppConstants.keyNotificationsEnabled,
      value: enabled.toString(),
    );
  }
}
