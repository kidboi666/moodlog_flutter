import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/widget.dart';
import '../write_view_model.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final locationInfo = context.select(
      (WriteViewModel vm) => vm.locationInfo,
    );

    if (locationInfo == null) {
      return IconButton(
        onPressed: () => context.read<WriteViewModel>().getCurrentLocation(),
        icon: Icon(Icons.location_on),
      ).scale();
    }

    return IconButton(
      onPressed: () => context.read<WriteViewModel>().clearLocation(),
      icon: Icon(Icons.location_on, color: colorScheme.primary),
      style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
    ).scale();
  }
}
