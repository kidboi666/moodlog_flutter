import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/presentation/screens/check_in/check_in_view_model.dart';
import 'package:moodlog/presentation/screens/journal/widgets/mood_bar.dart';
import 'package:moodlog/presentation/widgets/pop_button.dart';
import 'package:provider/provider.dart';

part 'check_in_content.dart';

class CheckInScreen extends StatelessWidget {
  final int id;

  const CheckInScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          CheckInViewModel(checkInUseCase: context.read(), id: id),
      child: _CheckInScreenContent(),
    );
  }
}
