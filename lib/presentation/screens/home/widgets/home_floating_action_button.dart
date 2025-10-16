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
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: DurationMS.medium,
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

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onQuickCheckIn() {
    _toggleExpanded();
    context.push(Routes.quickCheckIn);
  }

  void _onWriteJournal() {
    _toggleExpanded();
    context.push(Routes.write);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isExpanded) ...[
          _buildActionButton(
            icon: Icons.bolt,
            label: t.home_button_quick_check_in,
            onPressed: _onQuickCheckIn,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: Spacing.sm),
          _buildActionButton(
            icon: Icons.create,
            label: t.home_button_write_journal,
            onPressed: _onWriteJournal,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: Spacing.sm),
        ],
        FloatingActionButton(
          onPressed: _toggleExpanded,
          child: RotationTransition(
            turns: _rotationAnimation,
            child: Icon(_isExpanded ? Icons.close : Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required ColorScheme colorScheme,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: colorScheme.surface,
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.sm,
              vertical: Spacing.xs,
            ),
            child: Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: Spacing.sm),
        FloatingActionButton.small(
          onPressed: onPressed,
          heroTag: label,
          child: Icon(icon),
        ),
      ],
    );
  }
}
