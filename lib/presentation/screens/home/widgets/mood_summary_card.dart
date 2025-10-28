import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadDailySummary();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _loadDailySummary();
    });
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () => context.push(Routes.moodSummary),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.12,
                        ),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    CommonSizedBox.widthMd,
                    Expanded(
                      child: Text(
                        t.mood_summary_title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ],
                ),
                CommonSizedBox.heightLg,
                Text(
                  t.mood_summary_empty_subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
                CommonSizedBox.heightMd,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.03),
              theme.colorScheme.secondary.withValues(alpha: 0.03),
            ],
          ),
        ),
        child: InkWell(
          onTap: () => context.push(Routes.moodSummary),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: CommonPadding.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.primary.withValues(alpha: 0.2),
                            theme.colorScheme.secondary.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: theme.colorScheme.primary,
                        size: 26,
                      ),
                    ),
                    CommonSizedBox.widthLg,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.mood_summary_card_ready,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          CommonSizedBox.heightXs,
                          Text(
                            t.mood_summary_card_cta,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ],
                ),
                CommonSizedBox.heightMd,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${DateFormat.MMMd(Localizations.localeOf(context).languageCode).add_Hm().format(_dailySummary!.generatedAt)} ${t.mood_summary_generated_label}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.4,
                        ),
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        t.mood_summary_badge_new,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
