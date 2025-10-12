import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/common.dart';
import '../../extensions/date_time.dart';
import '../../extensions/routing.dart';
import '../../extensions/widget.dart';
import '../../l10n/app_localizations.dart';

class EmptyEntriesBox extends StatelessWidget {
  final bool isDisabled;
  final DateTime selectedDate;

  const EmptyEntriesBox({
    super.key,
    this.isDisabled = false,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isToday = selectedDate.isSameDay(DateTime.now());

    final buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.surfaceContainer.withValues(
            alpha: 0.5,
          );
        }
        return colorScheme.surfaceContainer;
      }),
    );

    Widget buildButton({
      required VoidCallback? onPressed,
      required IconData icon,
      required String label,
    }) {
      return FilledButton.tonal(
        onPressed: isDisabled ? null : onPressed,
        style: buttonStyle,
        child: Row(
          spacing: Spacing.md,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(label),
          ],
        ),
      ).scale();
    }

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(24),
        dashPattern: const [5, 5],
        strokeWidth: 1,
        color: colorScheme.outlineVariant,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          child: Column(
            spacing: Spacing.sm,
            children: [
              Column(
                spacing: Spacing.sm,
                children: [
                  Icon(
                    Icons.book_outlined,
                    size: 64,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                  Text(
                    t.entries_empty_box_title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outlineVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (isToday)
                buildButton(
                  onPressed: () =>
                      context.pushToWriteFromSelectedDate(DateTime.now()),
                  icon: Icons.add,
                  label: t.entries_empty_box_button,
                )
              else
                Column(
                  spacing: Spacing.sm,
                  children: [
                    buildButton(
                      onPressed: () =>
                          context.pushToWriteFromSelectedDate(selectedDate),
                      icon: Icons.calendar_today,
                      label: t.empty_box_write_for_selected_date(
                        DateFormat.yMMMd().format(selectedDate),
                      ),
                    ),
                    buildButton(
                      onPressed: () =>
                          context.pushToWriteFromSelectedDate(DateTime.now()),
                      icon: Icons.today,
                      label: t.empty_box_write_for_today,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
