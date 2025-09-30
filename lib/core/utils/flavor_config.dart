enum Flavor { development, staging, production }

class FlavorConfig {
  final Flavor flavor;
  final bool showDebugBanner;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor, bool showDebugBanner = true}) {
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
}
