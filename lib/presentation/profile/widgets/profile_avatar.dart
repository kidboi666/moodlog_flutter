import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/widgets/avatar.dart';

class ProfileAvatar extends StatelessWidget {
  final String? photoUrl;

  const ProfileAvatar({super.key, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Avatar(photoUrl: photoUrl, size: Spacing.xl * 4),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(Spacing.xs),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.all(Radius.circular(Spacing.xxl)),
            ),
            child: Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}
