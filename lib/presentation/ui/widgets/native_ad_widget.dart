import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/utils/admob_helper.dart';

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({super.key});

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isNativeAdReady = false;

  void _loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: AdmobHelper.nativeAdUnitId!,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isNativeAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('NativeAd failed to load: $error');
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
      ),
    );

    _nativeAd!.load();
  }

  @override
  void initState() {
    super.initState();
    _loadNativeAd();
  }

  @override
  Widget build(BuildContext context) {
    return _isNativeAdReady
        ? Container(
            color: Colors.grey,
            height: 100,
            child: AdWidget(ad: _nativeAd!),
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
