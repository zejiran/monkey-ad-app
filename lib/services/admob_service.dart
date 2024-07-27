import 'dart:io';
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
        onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: ${ad.adUnitId}, $error');
          ad.dispose();
        },
      ),
    );
    return ad;
  }

  static Future<InterstitialAd?> createInterstitialAd() async {
    InterstitialAd? interstitialAd;

    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('InterstitialAd loaded: ${ad.adUnitId}');
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          interstitialAd = null;
        },
      ),
    );

    return interstitialAd;
  }

  static Future<RewardedAd?> createRewardedAd() async {
    RewardedAd? rewardedAd;

    await RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('RewardedAd loaded: ${ad.adUnitId}');
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          rewardedAd = null;
        },
      ),
    );

    return rewardedAd;
  }
}
