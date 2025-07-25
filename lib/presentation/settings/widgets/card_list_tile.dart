import 'package:flutter/material.dart';

import '../../../core/extensions/widget_scale.dart';

class CardListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const CardListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(4.0),
      child: InkResponse(
        child: ListTile(
          onTap: onTap,
          title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text(subtitle),
          leading: Icon(icon),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    ).scale();
  }
}
