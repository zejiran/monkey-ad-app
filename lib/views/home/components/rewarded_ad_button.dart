import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_models/ad_provider.dart';

class RewardedAdButton extends StatelessWidget {
  const RewardedAdButton({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);

    return ElevatedButton(
      onPressed: adProvider.showRewardedAd,
      child: const Text('Show Rewarded Ad'),
    );
  }
}
