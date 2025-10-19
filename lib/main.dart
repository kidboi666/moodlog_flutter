import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moodlog/core/di/injection_container.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/core/services/logging_service.dart';
import 'package:moodlog/core/utils/database_utils.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/presentation/widgets/app_initializer.dart';
import 'package:provider/provider.dart';

Future<void> main({
  Future<void> Function(BuildContext context)? onAppStartedDev,
}) async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  FlavorService();
  final firebaseOptions = FlavorService.firebaseOptions;
  final logLevel = FlavorService.logLevel;

  await Firebase.initializeApp(options: firebaseOptions);
  await dotenv.load(fileName: '.env');
  await MobileAds.instance.initialize();

  final analyticsRepo = AnalyticsRepositoryImpl();
  await analyticsRepo.initialize();

  LoggingService.initialize(logLevel);

  await DatabaseUtils.cleanupOldDatabase();

  final providers = createProviders();

  runApp(
    MultiProvider(
      providers: providers,
      child: AppInitializer(
        analyticsRepo: analyticsRepo,
        onAppStartedDev: onAppStartedDev,
      ),
    ),
  );
}
