import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../providers/settings_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../scanner/providers/scanner_provider.dart';
import '../../../core/utils/currency_utils.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final auth = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Account section
          const _SectionHeader('Account'),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(auth.userName ?? 'Unknown'),
            subtitle: Text(auth.userEmail ?? 'Not signed in'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Sign Out?'),
                  content: const Text(
                    'You will need to sign in again to scan emails.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await ref.read(authProvider.notifier).signOut();
                if (context.mounted) context.go('/login');
              }
            },
          ),
          const Divider(),

          // Scan settings
          const _SectionHeader('Scan Settings'),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text('Date Range'),
            subtitle: Text(_dateRangeLabel(settings.scanDateRangeYears)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showDateRangePicker(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Auto-Scan Frequency'),
            subtitle: Text(
              settings.autoScanFrequency == 'manual'
                  ? 'Manual only'
                  : settings.autoScanFrequency.substring(0, 1).toUpperCase() +
                        settings.autoScanFrequency.substring(1),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showFrequencyPicker(context, ref),
          ),
          const Divider(),

          // Currency
          const _SectionHeader('Display'),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Primary Currency'),
            subtitle: Text(settings.primaryCurrency),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showCurrencyPicker(context, ref),
          ),
          const Divider(),

          // Notifications
          const _SectionHeader('Notifications'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Renewal Reminders'),
            subtitle: const Text('Get notified 3 days before expected renewal'),
            value: settings.notificationsEnabled,
            onChanged: (v) =>
                ref.read(settingsProvider.notifier).setNotificationsEnabled(v),
          ),
          const Divider(),

          // Data
          const _SectionHeader('Data'),
          ListTile(
            leading: const Icon(Icons.file_download),
            title: const Text('Export as CSV'),
            onTap: () => _exportCsv(context, ref),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: theme.colorScheme.error),
            title: Text(
              'Clear All Data',
              style: TextStyle(color: theme.colorScheme.error),
            ),
            onTap: () => _clearData(context, ref),
          ),
          const Divider(),

          // About
          const _SectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('SubTrack'),
            subtitle: Text('Version 1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Privacy Policy'),
            subtitle: const Text(
              'Your data stays on your device. We never upload your emails.',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.gavel),
            title: const Text('Licenses'),
            onTap: () => showLicensePage(
              context: context,
              applicationName: 'SubTrack',
              applicationVersion: '1.0.0',
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go('/dashboard');
            case 1:
              context.go('/subscriptions');
            case 2:
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'Subscriptions',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  String _dateRangeLabel(int years) {
    if (years == -1) return 'All time';
    return 'Last $years year${years > 1 ? 's' : ''}';
  }

  void _showDateRangePicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Scan Date Range'),
        children: [
          for (final y in [1, 2, 3, -1])
            SimpleDialogOption(
              onPressed: () {
                ref.read(settingsProvider.notifier).setScanDateRange(y);
                Navigator.pop(context);
              },
              child: Text(_dateRangeLabel(y)),
            ),
        ],
      ),
    );
  }

  void _showFrequencyPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Auto-Scan Frequency'),
        children: [
          for (final f in ['manual', 'weekly', 'monthly'])
            SimpleDialogOption(
              onPressed: () {
                ref.read(settingsProvider.notifier).setAutoScanFrequency(f);
                Navigator.pop(context);
              },
              child: Text(
                f == 'manual'
                    ? 'Manual only'
                    : f[0].toUpperCase() + f.substring(1),
              ),
            ),
        ],
      ),
    );
  }

  void _showCurrencyPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Primary Currency'),
        children: [
          for (final c in CurrencyUtils.supportedCurrencies)
            SimpleDialogOption(
              onPressed: () {
                ref.read(settingsProvider.notifier).setPrimaryCurrency(c);
                Navigator.pop(context);
              },
              child: Text(c),
            ),
        ],
      ),
    );
  }

  Future<void> _exportCsv(BuildContext context, WidgetRef ref) async {
    try {
      final db = ref.read(databaseProvider);
      final subs = await db.subscriptionDao.getAllSubscriptions();
      final payments = await db.paymentDao.getAllPayments();

      final rows = <List<dynamic>>[
        [
          'Service',
          'Category',
          'Amount',
          'Currency',
          'Date',
          'Billing Cycle',
          'Status',
        ],
      ];

      for (final p in payments) {
        final sub = subs.firstWhere(
          (s) => s.id == p.subscriptionId,
          orElse: () => subs.first,
        );
        rows.add([
          sub.serviceName,
          sub.serviceCategory ?? '',
          p.amount,
          p.currency,
          p.paymentDate.toIso8601String(),
          sub.billingCycle,
          sub.isActive ? 'Active' : 'Cancelled',
        ]);
      }

      final csv = const ListToCsvConverter().convert(rows);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/subtrack_export.csv');
      await file.writeAsString(csv);

      await Share.shareXFiles([XFile(file.path)], text: 'SubTrack Export');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  Future<void> _clearData(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will delete all subscriptions and payment records. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final db = ref.read(databaseProvider);
      await db.paymentDao.deleteAll();
      await db.subscriptionDao.deleteAll();
      await db.scanDao.deleteAll();

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('All data cleared')));
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
