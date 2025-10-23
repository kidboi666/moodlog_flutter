import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/presentation/widgets/activity_chip.dart';

class ActivitySection extends StatelessWidget {
  final List<Activity> activities;
  final String? title;
  final SimpleTextAlign? textAlign;
  final int? maxActivities;
  final double? spacing;
  final double? runSpacing;
  final bool isCompact;

  const ActivitySection({
    super.key,
    required this.activities,
    this.title,
    this.textAlign,
    this.maxActivities,
    this.spacing,
    this.runSpacing,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) return const SizedBox.shrink();

    final displayActivities = maxActivities != null ? activities.take(maxActivities!).toList() : activities;

    return Column(
      crossAxisAlignment:
          textAlign?.crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: _getWrapAlignment(
            textAlign?.crossAxisAlignment ?? CrossAxisAlignment.start,
          ),
          spacing: spacing ?? Spacing.sm,
          runSpacing: runSpacing ?? Spacing.sm,
          children: displayActivities.map((activity) {
            return ActivityChip(activity: activity, isCompact: isCompact);
          }).toList(),
        ),
      ],
    );
  }

  WrapAlignment _getWrapAlignment(CrossAxisAlignment crossAlignment) {
    switch (crossAlignment) {
      case CrossAxisAlignment.start:
        return WrapAlignment.start;
      case CrossAxisAlignment.center:
        return WrapAlignment.center;
      case CrossAxisAlignment.end:
        return WrapAlignment.end;
      default:
        return WrapAlignment.start;
    }
  }
}
