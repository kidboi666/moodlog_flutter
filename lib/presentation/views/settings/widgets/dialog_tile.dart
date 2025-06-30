import 'package:flutter/material.dart';

class DialogTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final GestureTapCallback? onTap;

  const DialogTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
