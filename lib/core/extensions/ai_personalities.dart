import 'package:flutter/material.dart';

import '../../presentation/view_models/onboarding/onboarding_viewmodel.dart';
import '../constants/common.dart';
import '../l10n/app_localizations.dart';

extension AiPersonalitiesExtension on AiPersonalities {
  String getTitle(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    switch (this) {
      case AiPersonalities.rational:
        return t.onboarding_personality_rational_title;
      case AiPersonalities.balanced:
        return t.onboarding_personality_balanced_title;
      case AiPersonalities.compassionate:
        return t.onboarding_personality_compassionate_title;
    }
  }

  String getDescription(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (this) {
      case AiPersonalities.rational:
        return t.onboarding_personality_rational_description;
      case AiPersonalities.balanced:
        return t.onboarding_personality_balanced_description;
      case AiPersonalities.compassionate:
        return t.onboarding_personality_compassionate_description;
    }
  }

  String getEmoji(BuildContext context) {
    switch (this) {
      case AiPersonalities.rational:
        return Emoji.rational;
      case AiPersonalities.balanced:
        return Emoji.balanced;
      case AiPersonalities.compassionate:
        return Emoji.compassionate;
    }
  }
}
