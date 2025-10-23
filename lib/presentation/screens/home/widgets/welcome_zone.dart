import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/edit_nickname_bottom_sheet.dart';
import 'package:provider/provider.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  void _showEditNicknameSheet(BuildContext context, String currentNickname) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          EditNicknameBottomSheet(currentNickname: currentNickname),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final nickname = context.select((HomeViewModel vm) => vm.nickname);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => _showEditNicknameSheet(context, nickname ?? ''),
              borderRadius: BorderRadius.circular(Roundness.sm),
              child: Padding(
                padding: CommonPadding.sm,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.home_welcome(nickname ?? ''),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    CommonSizedBox.widthXs,
                    Icon(
                      Icons.edit,
                      size: 16,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ],
                ),
              ),
            ),
            CommonSizedBox.widthMd,
          ],
        ),
        Text(
          t.home_howareyou,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
