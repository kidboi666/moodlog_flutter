import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_view.freezed.dart';

@freezed
abstract class ScreenView with _$ScreenView {
  const factory ScreenView({required String screenName, String? screenClass}) =
      _ScreenView;
}
