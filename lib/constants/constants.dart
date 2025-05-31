import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF03A9F4);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color cardColor = Color(0xFFFFFFFF);

  // Available theme colors
  static const List<Color> availableColors = [
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFF44336), // Red
    Color(0xFFFF9800), // Orange
    Color(0xFF9C27B0), // Purple
    Color(0xFF795548), // Brown
    Color(0xFF607D8B), // Blue Grey
  ];

  // Text sizes
  static const double smallTextSize = 12.0;
  static const double mediumTextSize = 16.0;
  static const double largeTextSize = 20.0;
  static const double extraLargeTextSize = 24.0;

  // Available text sizes
  static const List<double> availableTextSizes = [
    12.0, // Small
    14.0, // Medium
    16.0, // Large
    18.0, // Extra Large
    20.0, // XXL
  ];

  // Padding
  static const double smallPadding = 8.0;
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  // Border radius
  static const double borderRadius = 8.0;
  static const double buttonHeight = 48.0;

  // Animation duration
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Icon sizes
  static const double smallIconSize = 16.0;
  static const double defaultIconSize = 24.0;
  static const double largeIconSize = 32.0;

  // Drawer width
  static const double drawerWidth = 280.0;

  // Note card dimensions
  static const double noteCardWidth = 160.0;
  static const double noteCardHeight = 200.0;
  static const double noteCardSpacing = 16.0;

  // Search bar height
  static const double searchBarHeight = 48.0;

  // Profile image size
  static const double profileImageSize = 120.0;
  static const double avatarRadius = 60.0;

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String notesCollection = 'notes';
  static const String profilesCollection = 'profiles';

  // Asset Paths
  static const String defaultAvatarPath = 'assets/avatar.png';
  static const String logoPath = 'assets/logo.png';

  // Route Names
  static const String homeRoute = '/home';
  static const String loginRoute = '/';
  static const String registerRoute = '/register';
  static const String diaryRoute = '/diary';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
} 