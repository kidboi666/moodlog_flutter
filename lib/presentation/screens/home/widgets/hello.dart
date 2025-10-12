import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/home/widgets/waving_hand.dart';

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
        const WavingHand(),
      ],
    );
  }
}
