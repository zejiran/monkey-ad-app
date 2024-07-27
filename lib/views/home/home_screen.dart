import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/ad_provider.dart';
import 'components/ad_banner.dart';
import 'components/ad_button.dart';
import 'components/ad_monkey_dance.dart';
import 'components/confetti_display.dart';
import 'components/rewarded_ad_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);
    final isAdWatched = adProvider.adState.isAdWatched;

    return Scaffold(
      body: Stack(
        children: [
          const ConfettiDisplay(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isAdWatched)
                const AdMonkeyDance()
              else
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/logo.png'),
                        height: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Welcome to Ad Monkey Madness!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Click any of the buttons below to watch an ad and then see a monkey dancing!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      AdButton(),
                      SizedBox(height: 20),
                      RewardedAdButton(),
                    ],
                  ),
                ),
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
        ],
      ),
    );
  }
}
