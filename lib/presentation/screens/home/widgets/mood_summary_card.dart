import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/mood_summary/mood_summary.dart';
import 'package:moodlog/domain/use_cases/mood_summary_use_case.dart';
import 'package:provider/provider.dart';

class MoodSummaryCard extends StatefulWidget {
  const MoodSummaryCard({super.key});

  @override
  State<MoodSummaryCard> createState() => _MoodSummaryCardState();
}

class _MoodSummaryCardState extends State<MoodSummaryCard> {
  MoodSummary? _dailySummary;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDailySummary();
  }

  Future<void> _loadDailySummary() async {
    final useCase = context.read<MoodSummaryUseCase>();
    final result = await useCase.getLatestSummary(MoodSummaryPeriod.daily);

    if (mounted) {
      setState(() {
        _dailySummary = switch (result) {
          Ok(value: final summary) => summary,
          Error() => null,
        };
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (_isLoading) {
      return Card(
        child: Padding(
          padding: CommonPadding.lg,
          child: Center(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  CommonSizedBox.heightSm,
                  Text(
                    t.mood_summary_title,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_dailySummary == null) {
      return Card(
        child: InkWell(
          onTap: () => context.push(Routes.moodSummary),
          borderRadius: CommonBorderRadius.medium,
          child: Padding(
            padding: CommonPadding.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    CommonSizedBox.widthSm,
                    Expanded(
                      child: Text(
                        t.mood_summary_title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ],
                ),
                CommonSizedBox.heightMd,
                Text(
                  t.mood_summary_empty_subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                CommonSizedBox.heightSm,
                Text(
                  t.mood_summary_generate,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: InkWell(
        onTap: () => context.push(Routes.moodSummary),
        borderRadius: CommonBorderRadius.medium,
        child: Padding(
          padding: CommonPadding.lg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  CommonSizedBox.widthSm,
                  Expanded(
                    child: Text(
                      '${t.mood_summary_title} · ${t.mood_summary_daily}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ],
              ),
              CommonSizedBox.heightMd,
              _SummaryPreview(
                icon: Icons.favorite,
                label: t.mood_summary_dominant_moods,
                content: _dailySummary!.dominantMoods,
                color: theme.colorScheme.secondary,
              ),
              CommonSizedBox.heightSm,
              _SummaryPreview(
                icon: Icons.lightbulb,
                label: t.mood_summary_personal_advice,
                content: _dailySummary!.personalAdvice,
                color: theme.colorScheme.primary,
              ),
              CommonSizedBox.heightSm,
              Text(
                _formatDateTime(_dailySummary!.generatedAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.month}월 ${dateTime.day}일 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} 생성';
  }
}

class _SummaryPreview extends StatelessWidget {
  final IconData icon;
  final String label;
  final String content;
  final Color color;

  const _SummaryPreview({
    required this.icon,
    required this.label,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final previewText = content.length > 60
        ? '${content.substring(0, 60)}...'
        : content;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: color.withValues(alpha: 0.8),
        ),
        CommonSizedBox.widthXs,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                previewText,
                style: theme.textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
