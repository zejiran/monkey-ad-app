import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/admob_service.dart';
import 'theme/style.dart';
import 'utils/routes.dart';
import 'view_models/ad_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AdMobService.initialize();
  runApp(const MonkeyAdApp());
}

class MonkeyAdApp extends StatelessWidget {
  const MonkeyAdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdProvider(),
      child: MaterialApp(
        title: 'Ad Monkey Madness',
        theme: getAppTheme(),
        initialRoute: Routes.home,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
