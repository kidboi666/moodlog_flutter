import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../widgets/avatar.dart';
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
            // TODO: 이미지 페이지 이동 기능 (파이어베이스 요금제 업그레이드 필요)
            // ImageScreenWithButton(
            //   image: photoUrl,
            //   button: Avatar(photoUrl: photoUrl, size: Spacing.xl * 4),
            // ),
            Avatar(
              photoUrl: photoUrl,
              size: Spacing.xl * 4,
              onTap: () {
                //TODO: 이미지 페이지 이동 기능 (파이어베이스 요금제 업그레이드 필요)
              },
            ),

            // TODO: 이미지 업로드 기능 (파이어베이스 요금제 업그레이드 필요)
            // Positioned(
            //   bottom: -12,
            //   right: -12,
            //   child: IconButton.filledTonal(
            //     padding: EdgeInsets.all(Spacing.sm),
            //     constraints: const BoxConstraints(),
            //     iconSize: 20,
            //     icon: const Icon(Icons.edit),
            //     onPressed: () async {

            // final result = await context
            //     .read<ProfileViewModel>()
            //     .pickImage();
            // if (context.mounted) {
            //   switch (result) {
            //     case Ok<void>():
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('프로필 이미지가 변경되었습니다.')),
            //       );
            //     case Failure<void>():
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text(result.error.toString())),
            //       );
            //   }
            // }
            //   },
            // ).scale(),
            // ),
          ],
        );
      },
    );
  }
}
