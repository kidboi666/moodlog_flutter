import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/router/routes.dart';

class JournalCard extends StatelessWidget {
  final int id;
  final String content;
  final String moodName;
  final String? coverImg;
  final DateTime createdAt;

  const JournalCard({
    super.key,
    required this.id,
    required this.content,
    required this.moodName,
    required this.createdAt,
    this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    final title = '${createdAt.toLocal().toString()} - $moodName';
    return Card(
      child: InkWell(
        onTap: () => context.push(Routes.journal(id)),
        borderRadius: BorderRadius.circular(12.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: Container(width: 8),
          title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          subtitle: Text(content, style: Theme.of(context).textTheme.bodyLarge),
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
