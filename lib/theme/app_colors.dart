import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Secondary palette
  static const Color secondary = Color(0xFF06B6D4); // Cyan
  static const Color secondaryLight = Color(0xFF22D3EE);
  static const Color secondaryDark = Color(0xFF0891B2);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Category colors
  static const Color entertainment = Color(0xFFEC4899);
  static const Color productivity = Color(0xFF8B5CF6);
  static const Color cloudDev = Color(0xFF06B6D4);
  static const Color utilities = Color(0xFF10B981);
  static const Color newsLearning = Color(0xFFF59E0B);
  static const Color other = Color(0xFF6B7280);

  // Surface colors (light)
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFE2E8F0);

  // Surface colors (dark)
  static const Color surfaceDark = Color(0xFF0F172A);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color dividerDark = Color(0xFF334155);

  static Color categoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'entertainment':
        return entertainment;
      case 'productivity':
        return productivity;
      case 'cloud/dev':
        return cloudDev;
      case 'utilities':
        return utilities;
      case 'news/learning':
        return newsLearning;
      default:
        return other;
    }
  }
}
