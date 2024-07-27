import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/ad_provider.dart';

class AdButton extends StatelessWidget {
  const AdButton({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);
    final isLoading = adProvider.isLoading;

    return ElevatedButton(
      onPressed: isLoading ? null : adProvider.showInterstitialAd,
      child: const Text('Make it dance for 1 second!'),
    );
  }
}
