import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(value: true, onChanged: (value) {}),
          ),
        ],
      ),
    );
  }
}
