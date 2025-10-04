import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/firebase_options_dev.dart' as development;
import 'package:provider/provider.dart';

import 'core/di/injection_container.dart';
import 'core/utils/flavor_config.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: development.DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  FlavorConfig(flavor: Flavor.development, showDebugBanner: true);
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(MultiProvider(providers: createProviders(), child: MoodLogApp()));
}
