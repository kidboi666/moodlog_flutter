import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/common.dart';

class GoogleAccountCard extends StatelessWidget {
  final String email;

  const GoogleAccountCard({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        SvgPicture.asset('assets/svg/google-icon.svg', width: 24, height: 24),
        const SizedBox(width: Spacing.md),
        Text(email, style: textTheme.bodySmall),
      ],
    );
  }
}
