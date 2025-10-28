part of 'check_in_view.dart';

class _CheckInScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<CheckInViewModel>();
    final (:isLoading, :hasError, :checkIn) = context.select(
      (CheckInViewModel vm) =>
          (isLoading: vm.isLoading, hasError: vm.hasError, checkIn: vm.checkIn),
    );

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (hasError || checkIn == null) {
      return Scaffold(
        appBar: AppBar(leading: PopButton(onTap: () => context.pop())),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              CommonSizedBox.heightLg,
              Text(
                t.check_in_not_found,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CommonSizedBox.heightMd,
              Text(
                t.check_in_not_found_description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: PopButton(onTap: () => context.pop()),
        title: Row(
          spacing: Spacing.md,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              checkIn.createdAt.formattedDotNation(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              DateFormat('HH:mm').format(checkIn.createdAt),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case 'edit':
                  await context.push(
                    '${Routes.quickCheckIn}?checkInId=${viewModel.id}',
                  );
                  if (context.mounted) {
                    await viewModel.reload();
                  }
                  break;
                case 'delete':
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(t.check_in_delete_confirm_title),
                      content: Text(t.check_in_delete_confirm_description),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(t.cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(t.common_confirm_delete),
                        ),
                      ],
                    ),
                  );

                  if (shouldDelete == true) {
                    final result = await viewModel.delete();
                    if (context.mounted) {
                      switch (result) {
                        case Ok():
                          context.pop();
                        case Error():
                          break;
                      }
                    }
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit),
                    const SizedBox(width: Spacing.sm),
                    Text(t.check_in_edit),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete),
                    CommonSizedBox.widthSm,
                    Text(t.common_confirm_delete),
                  ],
                ),
              ),
            ],
          ).scale(),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MoodBar(moodType: checkIn.moodType),
          Expanded(
            child: ListView(
              children: [
                HeroMoodBanner(checkIn: checkIn),
                Padding(
                  padding: CommonPadding.xl,
                  child: Column(
                    children: [
                      FadeIn(
                        delay: DelayMS.medium,
                        child: _buildEmotionsSection(context, checkIn),
                      ),
                      CommonSizedBox.heightMd,
                      FadeIn(
                        delay: DelayMS.medium * 2,
                        child: _buildActivitiesSection(context, checkIn),
                      ),
                      if (checkIn.sleepQuality != null) ...[
                        CommonSizedBox.heightMd,
                        FadeIn(
                          delay: DelayMS.medium * 3,
                          child: _buildSleepQualitySection(context, checkIn),
                        ),
                      ],
                      if (checkIn.memo != null && checkIn.memo!.isNotEmpty) ...[
                        CommonSizedBox.heightMd,
                        FadeIn(
                          delay: DelayMS.medium * 4,
                          child: _buildMemoSection(context, checkIn),
                        ),
                      ],
                      CommonSizedBox.heightMd,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionsSection(BuildContext context, checkIn) {
    final t = AppLocalizations.of(context)!;
    final hasEmotions =
        checkIn.emotions != null && checkIn.emotions!.isNotEmpty;

    return _buildSection(
      context,
      title: t.check_in_emotions,
      icon: Icons.sentiment_satisfied_alt,
      child: hasEmotions
          ? Wrap(
              spacing: Spacing.sm,
              runSpacing: Spacing.sm,
              children: checkIn.emotions!
                  .map<Widget>(
                    (emotion) => Chip(
                      label: Text(emotion.name),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                    ),
                  )
                  .toList(),
            )
          : Text(
              t.check_in_emotions_empty,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
    );
  }

  Widget _buildActivitiesSection(BuildContext context, checkIn) {
    final t = AppLocalizations.of(context)!;
    final hasActivities =
        checkIn.activities != null && checkIn.activities!.isNotEmpty;

    return _buildSection(
      context,
      title: t.check_in_activities,
      icon: Icons.local_activity,
      child: hasActivities
          ? Wrap(
              spacing: Spacing.sm,
              runSpacing: Spacing.sm,
              children: checkIn.activities!
                  .map<Widget>(
                    (tag) => Chip(
                      label: Text(tag.name),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                    ),
                  )
                  .toList(),
            )
          : Text(
              t.check_in_activities_empty,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
    );
  }

  Widget _buildSleepQualitySection(BuildContext context, checkIn) {
    final t = AppLocalizations.of(context)!;

    return _buildSection(
      context,
      title: t.check_in_sleep_quality,
      icon: Icons.bedtime,
      child: Center(
        child: SleepQualityIndicator(quality: checkIn.sleepQuality!),
      ),
    );
  }

  Widget _buildMemoSection(BuildContext context, CheckIn checkIn) {
    final t = AppLocalizations.of(context)!;

    return _buildSection(
      context,
      title: t.check_in_memo,
      icon: Icons.note_alt,
      child: Text(checkIn.memo!, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
    required IconData icon,
  }) {
    return Container(
      padding: CommonPadding.xl,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(Roundness.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              CommonSizedBox.widthSm,
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CommonSizedBox.heightMd,
          child,
        ],
      ),
    );
  }
}
