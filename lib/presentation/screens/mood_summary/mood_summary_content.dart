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
            if (isGenerating)
              const CircularProgressIndicator()
            else if (viewModel.shouldShowGenerateButton(period))
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
            else
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
      padding: const EdgeInsets.all(20.0),
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
          const SizedBox(height: 32),
          _SectionCard(
            title: t.mood_summary_emotional_flow,
            content: summary.emotionalFlow,
            icon: Icons.timeline,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_dominant_moods,
            content: summary.dominantMoods,
            icon: Icons.favorite,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_activity_patterns,
            content: summary.activityPatterns,
            icon: Icons.local_activity,
            color: theme.colorScheme.tertiary,
          ),
          const SizedBox(height: 24),
          _SectionCard(
            title: t.mood_summary_personal_advice,
            content: summary.personalAdvice,
            icon: Icons.lightbulb,
            color: theme.colorScheme.primary,
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

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ),
            CommonSizedBox.widthLg,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    content,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.15),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                CommonSizedBox.widthLg,
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 20),
            Text(
              content,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.7,
                letterSpacing: 0.2,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
