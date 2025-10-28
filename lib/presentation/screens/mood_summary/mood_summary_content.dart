part of 'mood_summary_view.dart';

class _MoodSummaryContent extends StatefulWidget {
  const _MoodSummaryContent();

  @override
  State<_MoodSummaryContent> createState() => _MoodSummaryContentState();
}

class _MoodSummaryContentState extends State<_MoodSummaryContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isLoading = context.select<MoodSummaryViewModel, bool>(
      (vm) => vm.isLoading,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(t.mood_summary_title),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: t.mood_summary_daily),
            Tab(text: t.mood_summary_weekly),
            Tab(text: t.mood_summary_monthly),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<MoodSummaryViewModel>().refresh();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: const [
                _DailySummaryTab(),
                _WeeklySummaryTab(),
                _MonthlySummaryTab(),
              ],
            ),
    );
  }
}

class _DailySummaryTab extends StatelessWidget {
  const _DailySummaryTab();

  @override
  Widget build(BuildContext context) {
    final summary = context.select<MoodSummaryViewModel, dynamic>(
      (vm) => vm.dailySummary,
    );
    final isGenerating = context.select<MoodSummaryViewModel, bool>(
      (vm) => vm.isGenerating,
    );

    if (summary == null) {
      return _EmptyState(
        period: MoodSummaryPeriod.daily,
        isGenerating: isGenerating,
      );
    }

    return _SummaryContent(summary: summary);
  }
}

class _WeeklySummaryTab extends StatelessWidget {
  const _WeeklySummaryTab();

  @override
  Widget build(BuildContext context) {
    final summary = context.select<MoodSummaryViewModel, dynamic>(
      (vm) => vm.weeklySummary,
    );
    final isGenerating = context.select<MoodSummaryViewModel, bool>(
      (vm) => vm.isGenerating,
    );

    if (summary == null) {
      return _EmptyState(
        period: MoodSummaryPeriod.weekly,
        isGenerating: isGenerating,
      );
    }

    return _SummaryContent(summary: summary);
  }
}

class _MonthlySummaryTab extends StatelessWidget {
  const _MonthlySummaryTab();

  @override
  Widget build(BuildContext context) {
    final summary = context.select<MoodSummaryViewModel, dynamic>(
      (vm) => vm.monthlySummary,
    );
    final isGenerating = context.select<MoodSummaryViewModel, bool>(
      (vm) => vm.isGenerating,
    );

    if (summary == null) {
      return _EmptyState(
        period: MoodSummaryPeriod.monthly,
        isGenerating: isGenerating,
      );
    }

    return _SummaryContent(summary: summary);
  }
}

class _EmptyState extends StatelessWidget {
  final MoodSummaryPeriod period;
  final bool isGenerating;

  const _EmptyState({required this.period, required this.isGenerating});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final viewModel = context.read<MoodSummaryViewModel>();
    final timeRemaining = viewModel.getTimeRemainingText(period);
    final todayCheckInCount = context.select<MoodSummaryViewModel, int?>(
      (vm) => vm.todayCheckInCount,
    );

    final isDailyPeriod = period == MoodSummaryPeriod.daily;
    final hasEnoughCheckIns = todayCheckInCount != null && todayCheckInCount >= 3;
    final canGenerate = isDailyPeriod ? hasEnoughCheckIns : viewModel.shouldShowGenerateButton(period);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
              ),
              child: Icon(
                Icons.insights_outlined,
                size: 80,
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              t.mood_summary_empty_title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            CommonSizedBox.heightLg,
            Text(
              t.mood_summary_empty_subtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            if (isDailyPeriod && todayCheckInCount != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: hasEnoughCheckIns
                      ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5)
                      : theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hasEnoughCheckIns
                        ? theme.colorScheme.primary.withValues(alpha: 0.3)
                        : theme.colorScheme.error.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          hasEnoughCheckIns ? Icons.check_circle : Icons.info,
                          color: hasEnoughCheckIns
                              ? theme.colorScheme.primary
                              : theme.colorScheme.error,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          t.mood_summary_current_checkins(todayCheckInCount),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: hasEnoughCheckIns
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                    if (!hasEnoughCheckIns) ...[
                      const SizedBox(height: 8),
                      Text(
                        t.mood_summary_min_checkins_required,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            if (isGenerating)
              const CircularProgressIndicator()
            else if (canGenerate)
              FilledButton.icon(
                onPressed: () async {
                  await viewModel.generateSummary(period);
                  if (context.mounted && viewModel.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(viewModel.errorMessage!)),
                    );
                  }
                },
                icon: const Icon(Icons.auto_awesome),
                label: Text(t.mood_summary_generate),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              )
            else if (!isDailyPeriod)
              Text(
                timeRemaining,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryContent extends StatelessWidget {
  final dynamic summary;

  const _SummaryContent({required this.summary});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            title: t.mood_summary_generated_at,
            content: _formatDateTime(summary.generatedAt),
            icon: Icons.access_time,
          ),
          CommonSizedBox.heightMd,
          _InfoCard(
            title: t.mood_summary_period,
            content:
                '${_formatDate(summary.startDate)} ~ ${_formatDate(summary.endDate)}',
            icon: Icons.calendar_today,
          ),
          const SizedBox(height: 24),
          Divider(
            height: 1,
            thickness: 1.5,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_emotional_flow,
            content: summary.emotionalFlow,
            icon: Icons.timeline,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Divider(
            height: 1,
            thickness: 0.5,
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_dominant_moods,
            content: summary.dominantMoods,
            icon: Icons.favorite,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(height: 24),
          Divider(
            height: 1,
            thickness: 0.5,
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_activity_patterns,
            content: summary.activityPatterns,
            icon: Icons.local_activity,
            color: theme.colorScheme.tertiary,
          ),
          const SizedBox(height: 24),
          Divider(
            height: 1,
            thickness: 0.5,
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_personal_advice,
            content: summary.personalAdvice,
            icon: Icons.lightbulb,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Divider(
            height: 1,
            thickness: 0.5,
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_key_points,
            content: summary.keyPoints,
            icon: Icons.star,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          size: 20,
        ),
        CommonSizedBox.widthMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const _SectionCard({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            CommonSizedBox.widthMd,
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          content,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.7,
            letterSpacing: 0.1,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}
