import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;
import '../../scanner/providers/scanner_provider.dart';
import '../providers/subscriptions_provider.dart';
import '../../../database/app_database.dart';

class AddSubscriptionScreen extends ConsumerStatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  ConsumerState<AddSubscriptionScreen> createState() =>
      _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends ConsumerState<AddSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String _currency = 'USD';
  String _billingCycle = 'monthly';
  String _category = 'Other';
  DateTime _startDate = DateTime.now();

  static const _categories = [
    'Entertainment',
    'Productivity',
    'Cloud/Dev',
    'Utilities',
    'News/Learning',
    'Other',
  ];

  static const _currencies = ['USD', 'EUR', 'GBP', 'INR', 'CAD', 'AUD', 'JPY'];
  static const _cycles = ['weekly', 'monthly', 'quarterly', 'annual'];

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Subscription')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Service Name *',
                hintText: 'e.g. Netflix, Spotify',
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount *',
                      hintText: '9.99',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (double.tryParse(v) == null) return 'Invalid number';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _currency,
                    decoration: const InputDecoration(labelText: 'Currency'),
                    items: _currencies
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => _currency = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _billingCycle,
              decoration: const InputDecoration(labelText: 'Billing Cycle'),
              items: _cycles
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c[0].toUpperCase() + c.substring(1)),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _billingCycle = v!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Start Date'),
              subtitle: Text(
                '${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2010),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => _startDate = picked);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                hintText: 'Any additional info...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: const Text(
                  'Save Subscription',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);
    final amount = double.parse(_amountController.text);

    await db.subscriptionDao.insertSubscription(
      SubscriptionsCompanion.insert(
        serviceName: _nameController.text.trim(),
        serviceCategory: Value(_category),
        senderEmail: 'manual@entry',
        senderDomain: 'manual',
        typicalAmount: amount,
        currency: Value(_currency),
        billingCycle: Value(_billingCycle),
        firstSeenDate: _startDate,
        lastSeenDate: _startDate,
        isActive: const Value(true),
        notes: Value(
          _notesController.text.isNotEmpty
              ? _notesController.text.trim()
              : null,
        ),
      ),
    );

    // Reload subscriptions list
    ref.read(subscriptionsProvider.notifier).loadSubscriptions();

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Subscription added')));
      context.pop();
    }
  }
}
