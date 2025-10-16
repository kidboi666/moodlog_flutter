import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/routing/routes.dart';

extension RoutingExtension on BuildContext {
  void pushToJournalFromHome(int id) {
    push(Routes.journal(id), extra: {'source': JournalSource.home});
  }

  void pushToJournalFromEntries(int id) {
    push(Routes.journal(id), extra: {'source': JournalSource.entries});
  }

  void goToJournalFromWrite(int id) {
    go(Routes.journal(id), extra: {'source': JournalSource.write});
  }

  void pushToWriteFromSelectedDate(DateTime date) {
    push(Routes.write, extra: {'date': date});
  }

  void pushToEditCheckIn(int journalId) {
    push('${Routes.quickCheckIn}?journalId=$journalId');
  }
}
