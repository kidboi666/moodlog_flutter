import 'package:flutter/material.dart';

import '../../constants/common.dart';
import '../../extensions/widget.dart';

class Avatar extends StatelessWidget {
  final String? photoUrl;
  final double size;
  final VoidCallback? onTap;

  const Avatar({
    super.key,
    this.photoUrl,
    this.size = Spacing.lg * 2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkResponse(
      onTap: onTap,
      containedInkWell: true,
      borderRadius: BorderRadius.circular(size / 2),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: colorScheme.surfaceContainer,
        child: photoUrl != null && photoUrl!.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  photoUrl!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: size * 0.6);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: size * 0.6,
                      height: size * 0.6,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                ),
              )
            : Icon(Icons.person, size: size * 0.6),
      ),
    ).scale();
  }
}
