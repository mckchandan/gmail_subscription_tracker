/// Rules database for known subscription services.
/// Each rule helps identify and parse emails from popular services.
class SenderRule {
  final String serviceName;
  final String senderDomain;
  final List<String> senderEmails;
  final String category;
  final List<RegExp> amountPatterns;

  const SenderRule({
    required this.serviceName,
    required this.senderDomain,
    required this.senderEmails,
    required this.category,
    this.amountPatterns = const [],
  });
}

/// Known sender rules for 50+ subscription services
final List<SenderRule> knownSenderRules = [
  // ── Entertainment ──
  SenderRule(
    serviceName: 'Netflix',
    senderDomain: 'netflix.com',
    senderEmails: ['info@netflix.com', 'billing@netflix.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Spotify',
    senderDomain: 'spotify.com',
    senderEmails: ['no-reply@spotify.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Apple Music',
    senderDomain: 'apple.com',
    senderEmails: ['no_reply@email.apple.com', 'appleid@id.apple.com'],
    category: 'Entertainment',
    amountPatterns: [
      RegExp(r'[\$€£₹][\d,]+\.\d{2}'),
      RegExp(r'Total\s*[\$€£₹][\d,]+\.\d{2}'),
    ],
  ),
  SenderRule(
    serviceName: 'YouTube Premium',
    senderDomain: 'youtube.com',
    senderEmails: ['noreply@youtube.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Hulu',
    senderDomain: 'hulu.com',
    senderEmails: ['hulu@hulumail.com', 'hulu@e.hulu.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Disney+',
    senderDomain: 'disney.com',
    senderEmails: ['disneyplus@mail.disneyplus.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'HBO Max',
    senderDomain: 'hbomax.com',
    senderEmails: ['HBOMaxHelp@hbomax.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Amazon Prime',
    senderDomain: 'amazon.com',
    senderEmails: ['auto-confirm@amazon.com', 'digital-no-reply@amazon.com'],
    category: 'Entertainment',
    amountPatterns: [
      RegExp(r'[\$€£₹][\d,]+\.\d{2}'),
      RegExp(r'Total.*?[\$€£₹][\d,]+\.\d{2}'),
    ],
  ),
  SenderRule(
    serviceName: 'Audible',
    senderDomain: 'audible.com',
    senderEmails: ['notifications@audible.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Crunchyroll',
    senderDomain: 'crunchyroll.com',
    senderEmails: ['noreply@crunchyroll.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),

  // ── Productivity ──
  SenderRule(
    serviceName: 'Notion',
    senderDomain: 'notion.so',
    senderEmails: ['team@makenotion.com', 'notify@notion.so'],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Figma',
    senderDomain: 'figma.com',
    senderEmails: ['noreply@figma.com'],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Canva',
    senderDomain: 'canva.com',
    senderEmails: ['noreply@canva.com'],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Adobe Creative Cloud',
    senderDomain: 'adobe.com',
    senderEmails: ['mail@mail.adobe.com', 'adobeid@adobe.com'],
    category: 'Productivity',
    amountPatterns: [
      RegExp(r'[\$€£][\d,]+\.\d{2}'),
      RegExp(r'Total\s*[\$€£][\d,]+\.\d{2}'),
    ],
  ),
  SenderRule(
    serviceName: 'Grammarly',
    senderDomain: 'grammarly.com',
    senderEmails: ['info@send.grammarly.com', 'no-reply@grammarly.com'],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Microsoft 365',
    senderDomain: 'microsoft.com',
    senderEmails: [
      'microsoft-noreply@microsoft.com',
      'msa@communication.microsoft.com',
    ],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$€£₹][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Google Workspace',
    senderDomain: 'google.com',
    senderEmails: [
      'payments-noreply@google.com',
      'googleplay-noreply@google.com',
    ],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$€£₹][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Slack',
    senderDomain: 'slack.com',
    senderEmails: ['feedback@slack.com', 'billing@slack.com'],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Zoom',
    senderDomain: 'zoom.us',
    senderEmails: ['no-reply@zoom.us'],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Todoist',
    senderDomain: 'todoist.com',
    senderEmails: ['no-reply@todoist.com'],
    category: 'Productivity',
    amountPatterns: [RegExp(r'[\$€][\d,]+\.\d{2}')],
  ),

  // ── Cloud/Dev ──
  SenderRule(
    serviceName: 'AWS',
    senderDomain: 'amazonaws.com',
    senderEmails: [
      'aws-receivables-support@email.amazon.com',
      'no-reply@amazonaws.com',
    ],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Google Cloud',
    senderDomain: 'google.com',
    senderEmails: ['billing-noreply@google.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Azure',
    senderDomain: 'azure.com',
    senderEmails: ['azurecommunications@microsoft.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'GitHub',
    senderDomain: 'github.com',
    senderEmails: ['noreply@github.com', 'support@github.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'DigitalOcean',
    senderDomain: 'digitalocean.com',
    senderEmails: ['no-reply@digitalocean.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Vercel',
    senderDomain: 'vercel.com',
    senderEmails: ['billing@vercel.com', 'no-reply@vercel.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Heroku',
    senderDomain: 'heroku.com',
    senderEmails: ['billing@heroku.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'OpenAI',
    senderDomain: 'openai.com',
    senderEmails: ['noreply@tm.openai.com', 'support@openai.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Anthropic',
    senderDomain: 'anthropic.com',
    senderEmails: ['billing@anthropic.com', 'noreply@anthropic.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'JetBrains',
    senderDomain: 'jetbrains.com',
    senderEmails: ['sales@jetbrains.com', 'noreply@jetbrains.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$€][\d,]+\.\d{2}')],
  ),

  // ── Utilities ──
  SenderRule(
    serviceName: 'NordVPN',
    senderDomain: 'nordvpn.com',
    senderEmails: ['support@nordvpn.com', 'noreply@nordvpn.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'ExpressVPN',
    senderDomain: 'expressvpn.com',
    senderEmails: ['support@expressvpn.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Dropbox',
    senderDomain: 'dropbox.com',
    senderEmails: ['no-reply@dropbox.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'iCloud',
    senderDomain: 'icloud.com',
    senderEmails: ['no_reply@email.apple.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$€£₹][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Google One',
    senderDomain: 'google.com',
    senderEmails: ['googleone-noreply@google.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$€£₹][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: '1Password',
    senderDomain: '1password.com',
    senderEmails: ['billing@1password.com', 'support@1password.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'LastPass',
    senderDomain: 'lastpass.com',
    senderEmails: ['support@lastpass.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Bitwarden',
    senderDomain: 'bitwarden.com',
    senderEmails: ['no-reply@bitwarden.com'],
    category: 'Utilities',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),

  // ── News/Learning ──
  SenderRule(
    serviceName: 'Medium',
    senderDomain: 'medium.com',
    senderEmails: ['noreply@medium.com', 'yourfriends@medium.com'],
    category: 'News/Learning',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Substack',
    senderDomain: 'substack.com',
    senderEmails: ['no-reply@substack.com'],
    category: 'News/Learning',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'NYT',
    senderDomain: 'nytimes.com',
    senderEmails: ['nytdirect@nytimes.com', 'info@e.newyorktimes.com'],
    category: 'News/Learning',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Coursera',
    senderDomain: 'coursera.org',
    senderEmails: ['no-reply@coursera.org'],
    category: 'News/Learning',
    amountPatterns: [RegExp(r'[\$€][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Udemy',
    senderDomain: 'udemy.com',
    senderEmails: ['no-reply@e.udemymail.com', 'no-reply@udemy.com'],
    category: 'News/Learning',
    amountPatterns: [RegExp(r'[\$€£₹][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'LinkedIn Premium',
    senderDomain: 'linkedin.com',
    senderEmails: ['messages-noreply@linkedin.com', 'linkedin@e.linkedin.com'],
    category: 'News/Learning',
    amountPatterns: [RegExp(r'[\$€£][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Skillshare',
    senderDomain: 'skillshare.com',
    senderEmails: ['hello@skillshare.com', 'noreply@skillshare.com'],
    category: 'News/Learning',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'ChatGPT Plus',
    senderDomain: 'chatgpt.com',
    senderEmails: ['noreply@tm.openai.com'],
    category: 'Cloud/Dev',
    amountPatterns: [RegExp(r'[\$][\d,]+\.\d{2}')],
  ),
  SenderRule(
    serviceName: 'Amazon Prime Video',
    senderDomain: 'primevideo.com',
    senderEmails: ['digital-no-reply@amazon.com'],
    category: 'Entertainment',
    amountPatterns: [RegExp(r'[\$€£₹][\d,]+\.\d{2}')],
  ),
];

/// Lookup map by domain for fast matching
final Map<String, List<SenderRule>> knownSendersByDomain = () {
  final map = <String, List<SenderRule>>{};
  for (final rule in knownSenderRules) {
    map.putIfAbsent(rule.senderDomain, () => []).add(rule);
  }
  return map;
}();

/// Check if a domain belongs to a known sender and return matching rules
List<SenderRule> findRulesForDomain(String domain) {
  return knownSendersByDomain[domain.toLowerCase()] ?? [];
}

/// Check if a sender email matches any known sender
SenderRule? findRuleForEmail(String email) {
  final emailLower = email.toLowerCase();
  for (final rule in knownSenderRules) {
    if (rule.senderEmails.any((e) => emailLower.contains(e.toLowerCase()))) {
      return rule;
    }
  }
  // Fall back to domain match
  final domain = emailLower.split('@').lastOrNull;
  if (domain != null) {
    final rules = findRulesForDomain(domain);
    if (rules.isNotEmpty) return rules.first;
  }
  return null;
}
