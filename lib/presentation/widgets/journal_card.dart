import 'package:flutter/material.dart';

class JournalCard extends StatelessWidget {
  final String content;
  final Color moodColor;
  final String? coverImg;
  final DateTime createdAt;

  const JournalCard({
    super.key,
    required this.content,
    required this.moodColor,
    required this.createdAt,
    this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        leading: Container(width: 8, color: moodColor),
        title: Text(
          createdAt.toLocal().toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(content, style: Theme.of(context).textTheme.bodyLarge),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
