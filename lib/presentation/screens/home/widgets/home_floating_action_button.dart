import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';

class HomeFloatingActionButton extends StatefulWidget {
  const HomeFloatingActionButton({super.key});

  @override
  State<HomeFloatingActionButton> createState() =>
      _HomeFloatingActionButtonState();
}

class _HomeFloatingActionButtonState extends State<HomeFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: DurationMS.quick,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() async {
    _animationController.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.75),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: const _FloatingActionOverlay(),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _toggle,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FloatingActionOverlay extends StatelessWidget {
  const _FloatingActionOverlay();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => context.pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildActionButton(
              icon: Icons.bolt,
              label: t.home_button_quick_check_in,
              onPressed: () {
                context.pop();
                context.push(Routes.quickCheckIn);
              },
            ),
            CommonSizedBox.heightSm,
            _buildActionButton(
              icon: Icons.create,
              label: t.home_button_write_journal,
              onPressed: () {
                context.pop();
                context.push(Routes.write);
              },
            ),
            CommonSizedBox.heightSm,
            FloatingActionButton(
              onPressed: () => context.pop(),
              child: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          CommonSizedBox.widthSm,
          Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Roundness.md),
            ),
            child: Padding(padding: CommonPadding.sm, child: Icon(icon)),
          ),
        ],
      ),
    );
  }
}
