import 'package:flutter/material.dart';
import 'package:monkey_ad_app/views/home/home_screen.dart';

class Routes {
  static const String home = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
    };
  }
}
