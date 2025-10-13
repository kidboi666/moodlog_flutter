import 'package:flutter/material.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodLog Pro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Unlock Premium Features',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text('Cloud Backup & Sync'),
              subtitle: Text('Keep your journal safe across devices.'),
            ),
            const ListTile(
              leading: Icon(Icons.insights),
              title: Text('Advanced AI Analysis'),
              subtitle: Text('Get deeper insights into your mood patterns.'),
            ),
            const ListTile(
              leading: Icon(Icons.lock),
              title: Text('App Lock'),
              subtitle: Text('Secure your journal with biometrics.'),
            ),
            const ListTile(
              leading: Icon(Icons.file_download),
              title: Text('Export to PDF/CSV'),
              subtitle: Text('Save and share your journal entries.'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement in-app purchase logic
              },
              child: const Text('Upgrade Now'),
            ),
            const SizedBox(height: 8),
            Text(
              'One-time purchase. No subscription.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
