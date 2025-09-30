enum Flavor {
  development,
  staging,
  production,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return '무드로그 Dev';
      case Flavor.staging:
        return '무드로그 Staging';
      case Flavor.production:
        return '무드로그';
    }
  }

}
