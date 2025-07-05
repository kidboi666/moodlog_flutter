import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.tab_statistics)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.statistics_dev_title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.statistics_dev_description,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
