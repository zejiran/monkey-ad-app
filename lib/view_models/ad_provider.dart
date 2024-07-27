import 'dart:async';

import 'package:flutter/foundation.dart';
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

  Future<void> _loadInterstitialAd() async {
    _interstitialAd = await AdMobService.loadInterstitialAd();
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          if (kDebugMode) {
            print('Ad onAdShowedFullScreenContent.');
          }
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _loadInterstitialAd();
          _startMonkeyDance(1);
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          if (kDebugMode) {
            print('Ad onAdFailedToShowFullScreenContent: $error');
          }
          ad.dispose();
          _loadInterstitialAd();
        },
      );
    } else {
      if (kDebugMode) {
        print('InterstitialAd failed to load');
      }
    }
  }

  Future<void> _loadRewardedAd() async {
    _rewardedAd = await AdMobService.loadRewardedAd();
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          if (kDebugMode) {
            print('Ad onAdShowedFullScreenContent.');
          }
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _loadRewardedAd();
          _startMonkeyDance(5);
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          if (kDebugMode) {
            print('Ad onAdFailedToShowFullScreenContent: $error');
          }
          ad.dispose();
          _loadRewardedAd();
        },
      );
    } else {
      if (kDebugMode) {
        print('RewardedAd failed to load');
      }
    }
  }

  Future<void> showInterstitialAd() async {
    await _loadInterstitialAd();
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      if (kDebugMode) {
        print('Interstitial ad is not loaded yet.');
      }
    }
  }

  Future<void> showRewardedAd() async {
    await _loadRewardedAd();
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          if (kDebugMode) {
            print(
                '$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
          }
        },
      );
      _rewardedAd = null;
    } else {
      if (kDebugMode) {
        print('Rewarded ad is not loaded yet.');
      }
    }
  }

  void _startMonkeyDance(int durationInSeconds) {
    _adState.setAdWatched(true);
    notifyListeners();
    Timer(Duration(seconds: durationInSeconds), () {
      _adState.setAdWatched(false);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }
}
