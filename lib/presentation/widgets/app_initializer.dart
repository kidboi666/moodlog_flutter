import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moodlog/app.dart';
import 'package:moodlog/core/services/data_seeding_service.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

/// A widget that handles asynchronous initialization before building the main app.
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
    // Use addPostFrameCallback to ensure the first build is complete
    // before starting any async work that might update the state.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    // Access provider and load settings.
    await context.read<AppStateProvider>().loadSettings();

    // If the widget is still in the tree, update the state to show the main app.
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      // While initializing, the native splash screen is visible.
      // We return a container with the splash screen's background color
      // to prevent a flicker when the native splash screen disappears.
      return Container(color: const Color(0xFFFFFFFF));
    }

    // Once initialized, remove splash and build the main app.
    // Use addPostFrameCallback to ensure the new screen is ready before removing splash
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    return MoodLogApp(
      analyticsObserver: widget.analyticsRepo.navigatorObserver,
      onAppStarted: (context) async {
        await DataSeedingService(context).run();
        if (widget.onAppStartedDev != null) {
          await widget.onAppStartedDev!(context);
        }
      },
    );
  }
}
