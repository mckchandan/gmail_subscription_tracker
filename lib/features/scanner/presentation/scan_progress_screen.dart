import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/scanner_provider.dart';
import '../../../theme/app_colors.dart';

class ScanProgressScreen extends ConsumerStatefulWidget {
  const ScanProgressScreen({super.key});

  @override
  ConsumerState<ScanProgressScreen> createState() => _ScanProgressScreenState();
}

class _ScanProgressScreenState extends ConsumerState<ScanProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Start scanning after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(scannerProvider.notifier).startScan();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(scannerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanning Emails'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            ref.read(scannerProvider.notifier).cancelScan();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Animated scanner icon
              AnimatedBuilder(
                animation: _pulseController,
                builder: (_, __) => Transform.scale(
                  scale: 1.0 + (_pulseController.value * 0.1),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: progress.isComplete
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      progress.isComplete ? Icons.check_circle : Icons.radar,
                      size: 50,
                      color: progress.isComplete
                          ? AppColors.success
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Status text
              Text(
                progress.isComplete
                    ? 'Scan Complete!'
                    : progress.error != null
                    ? 'Scan Error'
                    : 'Scanning your inbox...',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (progress.currentQuery != null)
                Text(
                  progress.currentQuery!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              const SizedBox(height: 24),

              // Progress bar
              if (!progress.isComplete && progress.error == null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress.totalEmails > 0
                        ? progress.progressPercent
                        : null,
                    minHeight: 8,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
                const SizedBox(height: 8),
                if (progress.totalEmails > 0)
                  Text(
                    'Emails scanned: ${progress.processedEmails} / ${progress.totalEmails}',
                    style: theme.textTheme.bodyMedium,
                  ),
              ],

              const SizedBox(height: 32),

              // Stats cards
              Row(
                children: [
                  _StatCard(
                    icon: Icons.subscriptions,
                    label: 'Subscriptions',
                    value: '${progress.subscriptionsFound}',
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  _StatCard(
                    icon: Icons.payment,
                    label: 'Payments',
                    value: '${progress.paymentsFound}',
                    color: AppColors.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Services found list
              if (progress.servicesFound.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Services found:',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: progress.servicesFound.length,
                    itemBuilder: (_, i) {
                      final service = progress.servicesFound[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            service[0].toUpperCase(),
                            style: const TextStyle(color: AppColors.primary),
                          ),
                        ),
                        title: Text(service),
                        dense: true,
                      );
                    },
                  ),
                ),
              ] else
                const Spacer(),

              // Error message
              if (progress.error != null) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: theme.colorScheme.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          progress.error!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Bottom buttons
              if (progress.isComplete)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.go('/dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: const Text(
                      'View Dashboard',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              else if (progress.error != null)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.pop(),
                        child: const Text('Go Back'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            ref.read(scannerProvider.notifier).startScan(),
                        child: const Text('Retry'),
                      ),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(scannerProvider.notifier).cancelScan();
                      context.pop();
                    },
                    child: const Text('Cancel Scan'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
