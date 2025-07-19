import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../widgets/avatar.dart';
import '../../widgets/image_screen_with_button.dart';
import '../viewmodel/profile_viewmodel.dart';

class ProfileAvatar extends StatelessWidget {
  final String? image;

  const ProfileAvatar({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (image != null)
              ImageScreenWithButton(
                image: image!,
                button: Avatar(photoUrl: image, size: Spacing.xl * 4),
              )
            else
              Avatar(size: Spacing.xl * 4),

            Positioned(
              bottom: -12,
              right: -12,
              child: IconButton.filled(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  viewModel.pickImage(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
