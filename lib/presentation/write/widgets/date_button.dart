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
          onPressed: () async {
            final viewModel = context.read<WriteViewModel>();
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year - 5),
              lastDate: DateTime.now(),
              initialDate: selectedDate,
            );

            if (pickedDate != null && context.mounted) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(selectedDate),
              );

              if (pickedTime != null) {
                final newDate = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                viewModel.updateSelectedDate(newDate);
              }
            }
          },
          icon: Icon(Icons.calendar_month),
          style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
        );
      },
    );
  }
}
