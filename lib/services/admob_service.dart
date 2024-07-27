import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-8487654522231134/9392286895'
      : 'ca-app-pub-8487654522231134/xxxxxxxxxx';

  static String get interstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-8487654522231134/2817369751'
      : 'ca-app-pub-8487654522231134/xxxxxxxxxx';

  static String get rewardedAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-8487654522231134/6565043072'
      : 'ca-app-pub-8487654522231134/xxxxxxxxxx';

  static void initialize() {
    MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          if (kDebugMode) {
            print('Ad failed to load: ${ad.adUnitId}, $error');
          }
          ad.dispose();
        },
      ),
    );
    return ad;
  }

  static Future<InterstitialAd?> loadInterstitialAd() async {
    Completer<InterstitialAd?> completer = Completer();

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => completer.complete(ad),
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print('InterstitialAd failed to load: $error');
          }
          completer.complete(null);
        },
      ),
    );

    return completer.future;
  }

  static Future<RewardedAd?> loadRewardedAd() async {
    Completer<RewardedAd?> completer = Completer();

    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => completer.complete(ad),
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print('RewardedAd failed to load: $error');
          }
          completer.complete(null);
        },
      ),
    );

    return completer.future;
  }
}
