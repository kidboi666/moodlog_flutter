import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moodlog/core/services/admob_service.dart';
import 'package:moodlog/presentation/widgets/skeleton.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  bool _isBannerAdReady = false;

  void _loadBannerAd() {
    _bannerAd ??= BannerAd(
      size: AdSize.banner,
      adUnitId: AdmobService.bannerAdUnitId!,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('NativeAd failed to load: $error');
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return _isBannerAdReady
        ? SizedBox(height: 50, child: AdWidget(ad: _bannerAd!))
        : const Skeleton(height: 50);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
