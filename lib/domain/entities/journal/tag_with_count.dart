import 'package:moodlog/domain/entities/journal/tag.dart';

class TagWithCount {
  final Tag tag;
  final int count;

  TagWithCount({required this.tag, required this.count});
}
