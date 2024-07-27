import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/ad_provider.dart';

class RewardedAdButton extends StatelessWidget {
  const RewardedAdButton({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);
    final isLoading = adProvider.isLoading;

    return ElevatedButton(
      onPressed: isLoading ? null : adProvider.showRewardedAd,
      child: const Text('Even better! Make it dance for 5 seconds! 🤯'),
    );
  }
}
