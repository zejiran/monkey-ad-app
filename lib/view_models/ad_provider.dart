import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/ad_state.dart';
import '../services/admob_service.dart';

class AdProvider extends ChangeNotifier {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  final AdState _adState = AdState();

  AdProvider() {
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  AdState get adState => _adState;

  void _loadInterstitialAd() {
    AdMobService.createInterstitialAd().then((ad) {
      _interstitialAd = ad;
      _adState.setAdWatched(false);
      _interstitialAd?.setImmersiveMode(true);
    });
  }

  void _loadRewardedAd() {
    AdMobService.createRewardedAd().then((ad) {
      _rewardedAd = ad;
      _adState.setAdWatched(false);
    });
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          print('Ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('Ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          _loadInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          print('Ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          _loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('Ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          _loadRewardedAd();
        },
      );
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
          _adState.setAdWatched(true);
        },
      );
      _rewardedAd = null;
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }
}
