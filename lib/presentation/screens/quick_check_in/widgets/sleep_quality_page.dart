import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:provider/provider.dart';

class SleepQualityPage extends StatefulWidget {
  final void Function() onNext;
  final void Function() onBack;

  const SleepQualityPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<SleepQualityPage> createState() => SleepQualityPageState();
}

class SleepQualityPageState extends State<SleepQualityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _getSleepEmoji(int quality) {
    switch (quality) {
      case 1:
        return '🌕';
      case 2:
        return '🌖';
      case 3:
        return '🌗';
      case 4:
        return '🌘';
      case 5:
        return '🌑';
      default:
        return '🌗';
    }
  }

  String _getSleepLabel(int quality) {
    final t = AppLocalizations.of(context)!;
    switch (quality) {
      case 1:
        return t.quick_check_in_sleep_quality_1;
      case 2:
        return t.quick_check_in_sleep_quality_2;
      case 3:
        return t.quick_check_in_sleep_quality_3;
      case 4:
        return t.quick_check_in_sleep_quality_4;
      case 5:
        return t.quick_check_in_sleep_quality_5;
      default:
        return t.quick_check_in_sleep_quality_3;
    }
  }

  Color _getSleepColor(BuildContext context, int quality) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (quality) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return colorScheme.secondary;
      case 4:
        return colorScheme.primary.withValues(alpha: 0.8);
      case 5:
        return colorScheme.primary;
      default:
        return colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = AppLocalizations.of(context)!;
    final viewModel = context.watch<QuickCheckInViewModel>();
    final selectedQuality = viewModel.sleepQuality ?? 3;

    return Padding(
      padding: CommonPadding.xl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonSizedBox.heightXl,
          Text(t.quick_check_in_sleep_quality_title, style: Theme.of(context).textTheme.headlineSmall),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: DurationMS.quick,
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _getSleepColor(
                            context,
                            selectedQuality,
                          ).withValues(alpha: 0.1),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: DurationMS.quick,
                        child: Text(
                          _getSleepEmoji(selectedQuality),
                          key: ValueKey(selectedQuality),
                          style: const TextStyle(fontSize: 120),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  CommonSizedBox.heightMd,
                  AnimatedSwitcher(
                    duration: DurationMS.quick,
                    child: Text(
                      _getSleepLabel(selectedQuality),
                      key: ValueKey(selectedQuality),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: _getSleepColor(context, selectedQuality),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommonSizedBox.heightXl,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final quality = index + 1;
              final isSelected = selectedQuality == quality;

              return GestureDetector(
                onTap: () => viewModel.setSleepQuality(quality),
                child: AnimatedContainer(
                  duration: DurationMS.quick,
                  padding: CommonPadding.sm,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? _getSleepColor(
                            context,
                            quality,
                          ).withValues(alpha: 0.2)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? _getSleepColor(context, quality)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    _getSleepEmoji(quality),
                    style: TextStyle(fontSize: isSelected ? 40 : 32),
                  ),
                ),
              );
            }),
          ),
          CommonSizedBox.heightXl,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: widget.onBack,
                child: const Icon(Icons.arrow_back),
              ),
              FloatingActionButton(
                onPressed: widget.onNext,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          CommonSizedBox.heightMd,
        ],
      ),
    );
  }
}
