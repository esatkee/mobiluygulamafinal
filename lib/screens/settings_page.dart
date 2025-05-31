import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_page.dart';
import '../widgets/custom_drawer.dart';
import '../constants/constants.dart';
import '../constants/texts.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    
    return BasePage(
      title: AppTexts.settings,
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(AppTexts.appearance, [
              _buildColorPicker(context, settings),
              const SizedBox(height: AppConstants.defaultPadding),
              _buildTextSizePicker(context, settings),
              const SizedBox(height: AppConstants.defaultPadding),
              _buildSwitchTile(
                AppTexts.darkMode,
                settings.isDarkMode,
                (value) => settings.toggleDarkMode(value),
              ),
            ]),
            const Divider(height: AppConstants.largePadding),
            _buildSection(AppTexts.notifications, [
              _buildSwitchTile(
                AppTexts.enableNotifications,
                settings.notificationsEnabled,
                (value) => settings.toggleNotifications(value),
              ),
              if (settings.notificationsEnabled) ...[
                _buildSwitchTile(
                  AppTexts.sound,
                  settings.soundEnabled,
                  (value) => settings.toggleSound(value),
                ),
                _buildSwitchTile(
                  AppTexts.vibration,
                  settings.vibrationEnabled,
                  (value) => settings.toggleVibration(value),
                ),
              ],
            ]),
            const Divider(height: AppConstants.largePadding),
            _buildSection(AppTexts.about, [
              ListTile(
                title: Text(AppTexts.version),
                subtitle: const Text('1.0.0'),
              ),
              ListTile(
                title: Text(AppTexts.privacyPolicy),
                onTap: () {},
              ),
              ListTile(
                title: Text(AppTexts.termsOfService),
                onTap: () {},
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppConstants.largeTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        ...children,
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context, SettingsProvider settings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTexts.themeColor),
        const SizedBox(height: AppConstants.smallPadding),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppConstants.availableColors.length,
            itemBuilder: (context, index) {
              final color = AppConstants.availableColors[index];
              return GestureDetector(
                onTap: () => settings.updateThemeColor(color),
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: AppConstants.smallPadding),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: settings.themeColor == color ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextSizePicker(BuildContext context, SettingsProvider settings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTexts.textSize),
        const SizedBox(height: AppConstants.smallPadding),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppConstants.availableTextSizes.length,
            itemBuilder: (context, index) {
              final size = AppConstants.availableTextSizes[index];
              return GestureDetector(
                onTap: () => settings.updateTextSize(size),
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: AppConstants.smallPadding),
                  decoration: BoxDecoration(
                    color: settings.textSize == size ? AppConstants.primaryColor : Colors.grey[200],
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  child: Center(
                    child: Text(
                      'Aa',
                      style: TextStyle(
                        fontSize: size * 0.5,
                        color: settings.textSize == size ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
} 