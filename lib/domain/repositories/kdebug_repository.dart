import 'package:flutter/foundation.dart';

abstract class KdebugRepository extends ChangeNotifier {
  Future<void> clearSharedPreferences();
}
