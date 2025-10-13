import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class MenuListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;

  const MenuListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: _buildLeadingIcong(context),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? _buildTrailingIcon(context),
    );
  }

  Widget _buildLeadingIcong(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: ColorScheme.of(context).secondary),
    );
  }

  Widget _buildTrailingIcon(BuildContext context) {
    return Icon(
      Icons.chevron_right,
      color: ColorScheme.of(context).onSurfaceVariant,
      size: 18,
    );
  }
}
