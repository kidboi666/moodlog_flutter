part of 'check_in_view.dart';

class _CheckInScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
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
              Text(l10n.check_in_not_found, style: textTheme.titleLarge),
              CommonSizedBox.heightMd,
              Text(
                l10n.check_in_not_found_description,
                style: textTheme.bodyMedium?.copyWith(
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
        title: Text(
          '${checkIn.createdAt.year}.${checkIn.createdAt.month.toString().padLeft(2, '0')}.${checkIn.createdAt.day.toString().padLeft(2, '0')} ${DateFormat('HH:mm').format(checkIn.createdAt)}',
          style: textTheme.titleLarge,
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
                      title: Text(l10n.check_in_delete_confirm_title),
                      content: Text(l10n.check_in_delete_confirm_description),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(l10n.cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(l10n.common_confirm_delete),
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
                    Text(l10n.check_in_edit),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete),
                    const SizedBox(width: Spacing.sm),
                    Text(l10n.common_confirm_delete),
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
              padding: CommonPadding.lg,
              children: [
                _buildMoodSection(context, checkIn, textTheme),
                CommonSizedBox.heightLg,
                _buildEmotionsSection(context, checkIn, l10n, textTheme),
                CommonSizedBox.heightLg,
                _buildActivitiesSection(context, checkIn, l10n, textTheme),
                if (checkIn.sleepQuality != null) ...[
                  CommonSizedBox.heightLg,
                  _buildSleepQualitySection(context, checkIn, l10n, textTheme),
                ],
                if (checkIn.memo != null && checkIn.memo!.isNotEmpty) ...[
                  CommonSizedBox.heightLg,
                  _buildMemoSection(context, checkIn, l10n, textTheme),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSection(BuildContext context, checkIn, TextTheme textTheme) {
    return Container(
      padding: CommonPadding.xl,
      decoration: BoxDecoration(
        color: checkIn.moodType.color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(Roundness.card),
      ),
      child: Center(
        child: Text(
          checkIn.moodType.emoji,
          style: const TextStyle(fontSize: 56),
        ),
      ),
    );
  }

  Widget _buildEmotionsSection(
    BuildContext context,
    checkIn,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
    final hasEmotions =
        checkIn.emotions != null && checkIn.emotions!.isNotEmpty;

    return _buildSection(
      context,
      title: l10n.check_in_emotions,
      textTheme: textTheme,
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
              l10n.check_in_emotions_empty,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
    );
  }

  Widget _buildActivitiesSection(
    BuildContext context,
    checkIn,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
    final hasActivities =
        checkIn.activities != null && checkIn.activities!.isNotEmpty;

    return _buildSection(
      context,
      title: l10n.check_in_activities,
      textTheme: textTheme,
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
              l10n.check_in_activities_empty,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
    );
  }

  Widget _buildSleepQualitySection(
    BuildContext context,
    checkIn,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
    return _buildSection(
      context,
      title: l10n.check_in_sleep_quality,
      textTheme: textTheme,
      child: Row(
        children: [
          ...List.generate(
            5,
            (index) => Icon(
              index < checkIn.sleepQuality! ? Icons.star : Icons.star_border,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          CommonSizedBox.widthSm,
          Text('${checkIn.sleepQuality}/5', style: textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildMemoSection(
    BuildContext context,
    checkIn,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
    return _buildSection(
      context,
      title: l10n.check_in_memo,
      textTheme: textTheme,
      child: Text(checkIn.memo!, style: textTheme.bodyLarge),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required TextTheme textTheme,
    required Widget child,
  }) {
    return Container(
      padding: CommonPadding.xl,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Roundness.card),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          CommonSizedBox.heightMd,
          child,
        ],
      ),
    );
  }
}
