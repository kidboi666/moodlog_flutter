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
        print(locationInfo);

        if (locationInfo == null) {
          return IconButton(
            onPressed: () {
              print('Location button pressed');
              viewModel.getCurrentLocation();
            },
            icon: Icon(Icons.location_on),
          );
        }

        return IconButton(
          onPressed: () => viewModel.clearLocation(),
          icon: Icon(
            Icons.location_on,
            color: Theme.of(context).colorScheme.primary,
          ),
          style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
        );
      },
    );
  }
}
