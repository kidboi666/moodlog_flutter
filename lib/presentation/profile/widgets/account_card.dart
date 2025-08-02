import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/enum.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../common/routing/routes.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'google_account_card.dart';

typedef AccountCardValue = ({
  bool isGoogleUser,
  String? email,
  bool isAnonymousUser,
});

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Selector<ProfileViewModel, AccountCardValue>(
      selector: (context, viewModel) => (
        isGoogleUser: viewModel.isGoogleUser,
        email: viewModel.user?.email,
        isAnonymousUser: viewModel.isAnonymousUser,
      ),
      builder: (context, viewModel, _) {
        return ListTile(
          leading: Text(t.profile_account_title, style: textTheme.titleSmall),
          title: Row(
            children: [
              const Expanded(child: SizedBox()),
              Column(
                children: [
                  if (viewModel.isGoogleUser)
                    GoogleAccountCard(email: viewModel.email ?? ''),
                  if (viewModel.isAnonymousUser)
                    FilledButton(
                      onPressed: () {
                        context.push(
                          Routes.signIn,
                          extra: {'source': SignInSource.profile},
                        );
                      },
                      child: Text(t.profile_button_login),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
