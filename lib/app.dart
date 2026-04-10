import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'theme/app_theme.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/onboarding_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/scanner/presentation/scan_progress_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/subscriptions/presentation/subscriptions_list_screen.dart';
import 'features/subscriptions/presentation/subscription_detail_screen.dart';
import 'features/subscriptions/presentation/add_subscription_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

/// Bridge between Riverpod state changes and GoRouter's refreshListenable.
class _AuthChangeNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final authChangeNotifier = _AuthChangeNotifier();

  ref.listen(authProvider, (_, __) {
    authChangeNotifier.notify();
  });

  ref.onDispose(authChangeNotifier.dispose);

  return GoRouter(
    initialLocation: '/onboarding',
    refreshListenable: authChangeNotifier,
    redirect: (context, state) {
      final isLoggedIn = ref.read(authProvider).isAuthenticated;
      final isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/onboarding';

      if (!isLoggedIn && !isLoggingIn) return '/onboarding';
      if (isLoggedIn && isLoggingIn) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/scan', builder: (_, __) => const ScanProgressScreen()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      GoRoute(
        path: '/subscriptions',
        builder: (_, __) => const SubscriptionsListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (_, __) => const AddSubscriptionScreen(),
          ),
          GoRoute(
            path: ':id',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return SubscriptionDetailScreen(subscriptionId: id);
            },
          ),
        ],
      ),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    ],
  );
});

class SubTrackApp extends ConsumerWidget {
  const SubTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'SubTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
