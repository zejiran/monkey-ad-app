import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/ad_provider.dart';
import 'components/ad_button.dart';
import 'components/rewarded_ad_button.dart';
import 'components/ad_banner.dart';
import 'components/ad_monkey_dance.dart';
import 'components/confetti_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);
    final isAdWatched = adProvider.adState.isAdWatched;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Monkey Madness'),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isAdWatched)
                AdMonkeyDance()
              else
                const Column(
                  children: [
                    Text(
                      'Welcome to Ad Monkey Madness!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Click the button below to watch an ad and then see a monkey dancing!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              const AdButton(),
              const SizedBox(height: 20),
              RewardedAdButton(),
            ],
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: AdBanner(),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AdBanner(),
          ),
          const ConfettiDisplay(),
        ],
      ),
    );
  }
}
