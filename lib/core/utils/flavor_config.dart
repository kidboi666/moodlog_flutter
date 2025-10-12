import 'package:firebase_core/firebase_core.dart';
import 'package:logging/logging.dart';

import '../../firebase_options.dart' as production;
import '../../firebase_options_dev.dart' as development;
import '../../firebase_options_staging.dart' as staging;

enum Flavor { development, staging, production }

class FlavorConfig {
  final Flavor flavor;
  final bool showDebugBanner;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    Flavor flavor = Flavor.production,
    bool showDebugBanner = false,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor: flavor,
      showDebugBanner: showDebugBanner,
    );
    return _instance!;
  }

  FlavorConfig._internal({required this.flavor, required this.showDebugBanner});

  static FlavorConfig get instance => _instance!;

  static bool get isDevelopment => instance.flavor == Flavor.development;

  static bool get isProduction => instance.flavor == Flavor.production;

  static bool get isStaging => instance.flavor == Flavor.staging;

  static FirebaseOptions get firebaseOptions {
    switch (instance.flavor) {
      case Flavor.development:
        return development.DefaultFirebaseOptions.currentPlatform;
      case Flavor.staging:
        return staging.DefaultFirebaseOptions.currentPlatform;
      case Flavor.production:
        return production.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static Level get logLevel {
    switch (instance.flavor) {
      case Flavor.development:
        return Level.ALL;
      case Flavor.staging:
        return Level.SEVERE;
      case Flavor.production:
        return Level.SEVERE;
    }
  }

  static String get dotEnvSurfix {
    return '.env';
    // switch (instance.flavor) {
    //   case Flavor.development:
    //     return '.env.development';
    //   case Flavor.staging:
    //     return '.env.staging';
    //   case Flavor.production:
    //     return '.env.production';
    // }
  }
}
