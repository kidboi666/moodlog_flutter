import 'package:flutter/material.dart';

class SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(4.0),
      child: InkWell(
        child: SwitchListTile(
          title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text(subtitle),
          secondary: Icon(icon),
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
