import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/write_viewmodel.dart';

class DateButton extends StatelessWidget {
  const DateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<WriteViewModel, DateTime>(
      selector: (context, viewModel) => viewModel.selectedDate,
      builder: (context, selectedDate, child) {
        return IconButton(
          onPressed: () => context.read<WriteViewModel>().selectDate(context),
          icon: Icon(Icons.calendar_month),
          style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
        );
      },
    );
  }
}
