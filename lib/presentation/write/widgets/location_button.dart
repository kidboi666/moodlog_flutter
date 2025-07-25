import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/write_viewmodel.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, child) {
        final locationInfo = viewModel.locationInfo;
        
        if (locationInfo == null) {
          return IconButton(
            onPressed: () => viewModel.getCurrentLocation(),
            icon: Icon(Icons.location_on, size: 20),
            style: IconButton.styleFrom(
              padding: EdgeInsets.all(8),
            ),
          );
        }
        
        return IconButton(
          onPressed: () => viewModel.clearLocation(),
          icon: Icon(Icons.location_on, size: 20, color: Theme.of(context).colorScheme.primary),
          style: IconButton.styleFrom(
            padding: EdgeInsets.all(8),
          ),
        );
      },
    );
  }
}