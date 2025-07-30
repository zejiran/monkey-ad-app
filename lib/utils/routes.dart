import 'package:flutter/material.dart';
import 'package:monkey_ad_app/views/home/home_screen.dart';
import 'package:monkey_ad_app/views/settings/settings_screen.dart';
import 'package:monkey_ad_app/views/achievements/achievements_screen.dart';

class Routes {
  static const String home = '/';
  static const String settings = '/settings';
  static const String achievements = '/achievements';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      settings: (context) => const SettingsScreen(),
      achievements: (context) => const AchievementsScreen(),
    };
  }
}
