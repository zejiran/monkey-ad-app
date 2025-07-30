import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../view_models/settings_provider.dart';
import '../../view_models/ad_provider.dart';
import '../../utils/routes.dart';
import 'components/settings_tile.dart';
import 'components/settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: Consumer2<SettingsProvider, AdProvider>(
        builder: (context, settingsProvider, adProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SettingsSection(
                title: 'Preferences',
                children: [
                  SoundSettingsTile(),
                  ThemeSettingsTile(),
                  NotificationSettingsTile(),
                ],
              ),
              const SizedBox(height: 24),
              SettingsSection(
                title: 'Statistics',
                children: [
                  StatisticsTile(
                    title: 'Total Dance Time',
                    subtitle:
                        '${(adProvider.monkeyDanceDuration / 3600).toStringAsFixed(2)} hours',
                    icon: Icons.music_note_outlined,
                  ),
                  const StatisticsTile(
                    title: 'Ads Watched',
                    subtitle: 'Coming soon',
                    icon: Icons.play_circle_outline,
                  ),
                  SettingsTile(
                    title: 'Reset Statistics',
                    subtitle: 'Clear all your progress data',
                    icon: Icons.refresh,
                    onTap: () => _showResetDialog(context, adProvider),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const SettingsSection(
                title: 'App',
                children: [
                  AchievementsTile(),
                  ShareAppTile(),
                  AboutAppTile(),
                ],
              ),
              const SizedBox(height: 24),
              const SettingsSection(
                title: 'Danger Zone',
                children: [
                  ResetAllSettingsTile(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _showResetDialog(BuildContext context, AdProvider adProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Statistics'),
          content: const Text(
            'Are you sure you want to reset all your statistics? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                adProvider.resetStatistics();
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: 'Statistics reset successfully!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}

class SoundSettingsTile extends StatelessWidget {
  const SoundSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return SettingsTile(
          title: 'Sound Effects',
          subtitle: settingsProvider.soundEnabled ? 'Enabled' : 'Disabled',
          icon: settingsProvider.soundEnabled
              ? Icons.volume_up
              : Icons.volume_off,
          trailing: Switch(
            value: settingsProvider.soundEnabled,
            onChanged: (_) => settingsProvider.toggleSound(),
          ),
          onTap: () => settingsProvider.toggleSound(),
        );
      },
    );
  }
}

class ThemeSettingsTile extends StatelessWidget {
  const ThemeSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return SettingsTile(
          title: 'Dark Mode',
          subtitle: settingsProvider.isDarkMode ? 'Enabled' : 'Disabled',
          icon:
              settingsProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          trailing: Switch(
            value: settingsProvider.isDarkMode,
            onChanged: (_) => settingsProvider.toggleTheme(),
          ),
          onTap: () => settingsProvider.toggleTheme(),
        );
      },
    );
  }
}

class NotificationSettingsTile extends StatelessWidget {
  const NotificationSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return SettingsTile(
          title: 'Notifications',
          subtitle:
              settingsProvider.notificationsEnabled ? 'Enabled' : 'Disabled',
          icon: settingsProvider.notificationsEnabled
              ? Icons.notifications
              : Icons.notifications_off,
          trailing: Switch(
            value: settingsProvider.notificationsEnabled,
            onChanged: (_) => settingsProvider.toggleNotifications(),
          ),
          onTap: () => settingsProvider.toggleNotifications(),
        );
      },
    );
  }
}

class StatisticsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const StatisticsTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: title,
      subtitle: subtitle,
      icon: icon,
      onTap: null,
    );
  }
}

class ShareAppTile extends StatelessWidget {
  const ShareAppTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Share App',
      subtitle: 'Tell your friends about Ad Monkey Madness!',
      icon: Icons.share,
      onTap: () {
        Share.share(
          'Check out Ad Monkey Madness! 🐒💃\n\nWatch ads and see an amazing dancing monkey with confetti and sound effects!\n\nDownload now on Google Play Store!',
          subject: 'Ad Monkey Madness - Fun App!',
        );
      },
    );
  }
}

class AboutAppTile extends StatelessWidget {
  const AboutAppTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'About',
      subtitle: 'App version and information',
      icon: Icons.info_outline,
      onTap: () => _showAboutDialog(context),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Ad Monkey Madness',
      applicationVersion: '1.0.6+7',
      applicationIcon: const Icon(
        Icons.pets,
        size: 48,
      ),
      children: [
        const Text(
          'Welcome to Ad Monkey Madness! Click the button to see an ad and enjoy a dancing monkey with confetti and sound effects.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Developed with ❤️ using Flutter',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

class ResetAllSettingsTile extends StatelessWidget {
  const ResetAllSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Reset All Settings',
      subtitle: 'Reset all preferences to default values',
      icon: Icons.settings_backup_restore,
      onTap: () => _showResetAllDialog(context),
      titleColor: Theme.of(context).colorScheme.error,
    );
  }

  void _showResetAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset All Settings'),
          content: const Text(
            'Are you sure you want to reset all settings to their default values? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<SettingsProvider>(context, listen: false)
                    .resetAllSettings();
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: 'All settings reset successfully!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Reset All'),
            ),
          ],
        );
      },
    );
  }
}

class AchievementsTile extends StatelessWidget {
  const AchievementsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Achievements',
      subtitle: 'View your progress and unlock rewards',
      icon: Icons.emoji_events,
      onTap: () {
        Navigator.pushNamed(context, Routes.achievements);
      },
    );
  }
}
