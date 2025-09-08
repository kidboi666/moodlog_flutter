import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/ui/widgets/shake_emoji.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      spacing: Spacing.sm,
      children: [
        Text(t.home_hello, style: textTheme.displaySmall),
        const ShakeEmoji(emoji: Emoji.shakeHand, size: 28, repeatCount: 5),
      ],
    );
  }
}
