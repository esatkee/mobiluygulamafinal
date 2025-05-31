import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  Color _themeColor = AppConstants.primaryColor;
  double _textSize = AppConstants.mediumTextSize;
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  // Getters
  Color get themeColor => _themeColor;
  double get textSize => _textSize;
  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;

  // Initialize settings
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  void _loadSettings() {
    _themeColor = Color(_prefs.getInt('themeColor') ?? AppConstants.primaryColor.value);
    _textSize = _prefs.getDouble('textSize') ?? AppConstants.mediumTextSize;
    _isDarkMode = _prefs.getBool('darkMode') ?? false;
    _notificationsEnabled = _prefs.getBool('notifications') ?? true;
    _soundEnabled = _prefs.getBool('sound') ?? true;
    _vibrationEnabled = _prefs.getBool('vibration') ?? true;
    notifyListeners();
  }

  // Save settings to SharedPreferences
  Future<void> saveSettings() async {
    await _prefs.setInt('themeColor', _themeColor.value);
    await _prefs.setDouble('textSize', _textSize);
    await _prefs.setBool('darkMode', _isDarkMode);
    await _prefs.setBool('notifications', _notificationsEnabled);
    await _prefs.setBool('sound', _soundEnabled);
    await _prefs.setBool('vibration', _vibrationEnabled);
    notifyListeners();
  }

  // Update theme color
  void updateThemeColor(Color color) {
    _themeColor = color;
    saveSettings();
  }

  // Update text size
  void updateTextSize(double size) {
    _textSize = size;
    saveSettings();
  }

  // Toggle dark mode
  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    saveSettings();
  }

  // Toggle notifications
  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    saveSettings();
  }

  // Toggle sound
  void toggleSound(bool value) {
    _soundEnabled = value;
    saveSettings();
  }

  // Toggle vibration
  void toggleVibration(bool value) {
    _vibrationEnabled = value;
    saveSettings();
  }
} 