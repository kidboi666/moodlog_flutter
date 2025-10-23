import 'package:moodlog/domain/entities/journal/activity.dart';

class ActivityWithCount {
  final Activity activity;
  final int count;

  ActivityWithCount({
    required this.activity,
    required this.count,
  });
}
