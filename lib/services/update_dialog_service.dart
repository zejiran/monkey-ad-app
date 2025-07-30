import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/achievement.dart';
import 'version_service.dart';

class UpdateDialogService {
  static final VersionService _versionService = VersionService();

  /// Show welcome dialog for new users
  static Future<void> showWelcomeDialog(BuildContext context) async {
    final isFirst = await _versionService.isFirstLaunch();

    if (!isFirst) return;

    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Text('🐒'),
                SizedBox(width: 8),
                Text('Welcome!'),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Ad Monkey Madness!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '🎯 Watch ads to see amazing monkey dances\n'
                  '🎊 Enjoy confetti and sound effects\n'
                  '🏆 Unlock achievements as you play\n'
                  '⚙️ Customize your experience in settings\n'
                  '📊 Track your dancing statistics',
                ),
                SizedBox(height: 12),
                Text(
                  'Tap the settings icon in the top right to explore all features!',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                    msg: 'Let the monkey madness begin! 🐒💃',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
                child: const Text('Let\'s Start!'),
              ),
            ],
          );
        },
      );
    }
  }

  /// Show update dialog for existing users
  static Future<void> showUpdateDialog(BuildContext context) async {
    final hasUpdated = await _versionService.hasAppUpdated();

    if (!hasUpdated) return;

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Text('🎉'),
                SizedBox(width: 8),
                Text('What\'s New!'),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Version 1.1.0 Features:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '⚙️ New Settings Screen\n'
                  '   • Sound on/off toggle\n'
                  '   • Dark mode support\n'
                  '   • Statistics management\n\n'
                  '🏆 Achievement System\n'
                  '   • Track your progress\n'
                  '   • Unlock rewards\n'
                  '   • 10 unique achievements\n\n'
                  '📱 Enhanced Experience\n'
                  '   • Share the app with friends\n'
                  '   • Better app information\n'
                  '   • Improved user interface',
                ),
                SizedBox(height: 12),
                Text(
                  'Check out the settings icon to explore all new features!',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Maybe Later'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/achievements');
                },
                child: const Text('View Achievements'),
              ),
            ],
          );
        },
      );
    }
  }

  /// Show achievement unlock notification
  static void showAchievementUnlocked(
    BuildContext context,
    Achievement achievement,
  ) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Row(
            children: [
              Text(achievement.iconPath),
              const SizedBox(width: 8),
              const Text('Achievement Unlocked!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                achievement.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                achievement.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Icon(
                Icons.celebration,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Awesome!'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/achievements');
              },
              child: const Text('View All'),
            ),
          ],
        );
      },
    );
  }

  /// Show a toast notification for minor achievements
  static void showAchievementToast(Achievement achievement) {
    Fluttertoast.showToast(
      msg: '🏆 Achievement Unlocked: ${achievement.title}!',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show app rating dialog after certain achievements
  static void showRatingDialog(BuildContext context) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Text('⭐'),
              SizedBox(width: 8),
              Text('Enjoying Ad Monkey Madness?'),
            ],
          ),
          content: const Text(
            'We\'d love to hear your feedback! If you\'re enjoying the app, '
            'please consider rating us on the Google Play Store. '
            'Your support helps us make the app even better!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Maybe Later'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Here you would typically open the Play Store rating page
                Fluttertoast.showToast(
                  msg: 'Thank you for your support! 🎉',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
              child: const Text('Rate App'),
            ),
          ],
        );
      },
    );
  }
}
