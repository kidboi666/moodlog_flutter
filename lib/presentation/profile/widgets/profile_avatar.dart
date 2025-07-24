import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/utils/result.dart';
import '../../widgets/avatar.dart';
import '../../widgets/image_screen_with_button.dart';
import '../viewmodel/profile_viewmodel.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ProfileViewModel, String?>(
      selector: (_, viewModel) => viewModel.user?.photoURL,
      builder: (context, photoUrl, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (photoUrl != null)
              ImageScreenWithButton(
                image: photoUrl,
                button: Avatar(photoUrl: photoUrl, size: Spacing.xl * 4),
              )
            else
              Avatar(size: Spacing.xl * 4),

            Positioned(
              bottom: -12,
              right: -12,
              child: IconButton.filledTonal(
                padding: EdgeInsets.all(Spacing.xs),
                constraints: const BoxConstraints(),
                iconSize: 20,
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final result = await context
                      .read<ProfileViewModel>()
                      .pickImage();
                  if (context.mounted) {
                    switch (result) {
                      case Ok<void>():
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('프로필 이미지가 변경되었습니다.')),
                        );
                      case Error<void>():
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.error.toString())),
                        );
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
