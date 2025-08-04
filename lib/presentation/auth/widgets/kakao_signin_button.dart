import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../common/routing/routes.dart';
import '../../core/widgets/spinner.dart';
import '../viewmodel/auth_viewmodel.dart';

class KakaoSigninButton extends StatelessWidget {
  const KakaoSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, _) {
        return FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
          onPressed: viewModel.isLoading
              ? null
              : () {
                  viewModel.signInKakao();
                  context.go(
                    Routes.onboarding,
                    extra: {'loginType': LoginType.kakao},
                  );
                },
          child: viewModel.isLoadingKakao
              ? const Spinner(spinnerType: SpinnerType.button)
              : Row(
                  spacing: Spacing.md,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/kakao-icon.svg',
                      width: 24,
                      height: 24,
                    ),
                    Text(t.signin_button_kakao),
                  ],
                ),
        );
      },
    );
  }
}
