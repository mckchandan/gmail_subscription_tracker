class AppConstants {
  AppConstants._();

  static const String appName = 'SubTrack';
  static const String appDescription =
      'Track your Gmail subscriptions and spending';

  // Gmail API scopes
  static const List<String> gmailScopes = [
    'https://www.googleapis.com/auth/gmail.readonly',
  ];

  // Gmail query strategies
  static const String querySubjects =
      'subject:(subscription OR receipt OR invoice OR payment OR billing OR renewal OR charge)';

  static const String queryKnownSenders =
      'from:(netflix.com OR spotify.com OR apple.com OR google.com OR amazon.com '
      'OR adobe.com OR microsoft.com OR youtube.com OR hulu.com OR disney.com '
      'OR hbomax.com OR primevideo.com OR dropbox.com OR notion.so OR figma.com '
      'OR canva.com OR openai.com OR anthropic.com OR github.com OR slack.com '
      'OR zoom.us OR linkedin.com OR medium.com OR grammarly.com OR nordvpn.com '
      'OR expressvpn.com OR icloud.com OR chatgpt.com)';

  static const String queryPaymentSubjects =
      'subject:(your payment OR payment received OR payment confirmation '
      'OR monthly charge OR annual charge OR auto-renewal OR successfully charged)';

  // Rate limiting
  static const int maxRequestsPerSecond = 5;
  static const Duration rateLimitInterval = Duration(milliseconds: 200);
  static const int maxRetries = 5;

  // Billing cycle thresholds (in days)
  static const int weeklyThresholdDays = 10;
  static const int monthlyThresholdDays = 45;
  static const int annualThresholdDays = 400;

  // Active subscription threshold multiplier
  static const double activeThresholdMultiplier = 1.5;

  // Date range options (in years)
  static const List<int> dateRangeOptions = [1, 2, 3, -1]; // -1 = all time

  // Secure storage keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyTokenExpiry = 'token_expiry';
  static const String keyUserEmail = 'user_email';
  static const String keyUserName = 'user_name';
  static const String keyUserPhoto = 'user_photo';

  // Settings keys
  static const String keyScanDateRange = 'scan_date_range';
  static const String keyAutoScanFrequency = 'auto_scan_frequency';
  static const String keyPrimaryCurrency = 'primary_currency';
  static const String keyNotificationsEnabled = 'notifications_enabled';
}
