import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moodlog/app.dart';
import 'package:moodlog/core/services/data_seeding_service.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class AppInitializer extends StatefulWidget {
  const AppInitializer({
    super.key,
    required this.analyticsRepo,
    this.onAppStartedDev,
  });

  final AnalyticsRepositoryImpl analyticsRepo;
  final Future<void> Function(BuildContext context)? onAppStartedDev;

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    await context.read<AppStateProvider>().loadSettings();

    if (mounted) {
      await DataSeedingService(context).run();
    }

    if (mounted && widget.onAppStartedDev != null) {
      await widget.onAppStartedDev!(context);
    }

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(color: const Color(0xFFFFFFFF));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    return MoodLogApp(
      analyticsObserver: widget.analyticsRepo.navigatorObserver,
    );
  }
}
