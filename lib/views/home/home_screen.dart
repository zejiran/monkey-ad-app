import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/routes.dart';
import '../../view_models/ad_provider.dart';
import '../../services/update_dialog_service.dart';
import 'components/ad_banner.dart';
import 'components/ad_button.dart';
import 'components/ad_monkey_dance.dart';
import 'components/confetti_display.dart';
import 'components/rewarded_ad_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInitialDialogs();
    });
  }

  Future<void> _showInitialDialogs() async {
    if (!mounted) return;

    // Show welcome dialog for new users
    await UpdateDialogService.showWelcomeDialog(context);

    if (!mounted) return;

    // Show update dialog for existing users
    await UpdateDialogService.showUpdateDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);
    final isAdWatched = adProvider.adState.isAdWatched;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Monkey Madness'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () {
              Navigator.pushNamed(context, Routes.achievements);
            },
            tooltip: 'Achievements',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Routes.settings);
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Stack(
        children: [
          const ConfettiDisplay(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isAdWatched)
                const AdMonkeyDance()
              else
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/logo.png'),
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Welcome to Ad Monkey Madness!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Click any of the buttons below to watch an ad and then see a monkey dancing!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      const AdButton(),
                      const SizedBox(height: 20),
                      const RewardedAdButton(),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Your monkey has danced for ${(adProvider.monkeyDanceDuration / 3600).toStringAsFixed(3)} hours 🕺🐒',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AdBanner(),
          ),
        ],
      ),
    );
  }
}
