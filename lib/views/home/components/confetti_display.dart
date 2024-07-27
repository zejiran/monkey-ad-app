import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';
import '../../../view_models/ad_provider.dart';

class ConfettiDisplay extends StatelessWidget {
  const ConfettiDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);
    final confettiController = ConfettiController(duration: const Duration(seconds: 5));

    if (adProvider.adState.isAdWatched) {
      confettiController.play();
    }

    return ConfettiWidget(
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive,
    );
  }
}
