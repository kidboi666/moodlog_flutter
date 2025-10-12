# 수정 구현 계획: 확장된 캘린더를 바텀시트로 이동

이 문서는 확장된 캘린더 뷰를 홈 화면에서 모달 바텀시트로 이동하는 리팩토링 작업의 단계별 구현 계획을 설명합니다.

## 1단계: 사전 준비 및 테스트

- [x] 모든 테스트를 실행하여 프로젝트가 수정 시작 전에 안정적인 상태인지 확인합니다.

## 2단계: `CalendarBottomSheet` 위젯 생성

- [x] `lib/presentation/screens/home/widgets/calendar_bottom_sheet.dart` 파일을 생성합니다.
- [x] `unified_calendar.dart`의 `_GridView`와 `_CalendarHeader` 위젯 코드를 새 파일로 이동하여 `CalendarBottomSheet`라는 이름의 `StatelessWidget`으로 만듭니다.
- [x] `HomeViewModel`에서 필요한 데이터를 `Provider`를 통해 가져오도록 연결합니다.

## 3단계: `HomeAppBar` 수정

- [x] `home_app_bar.dart` 파일을 엽니다.
- [x] 기존 캘린더 뷰 토글 `IconButton`의 `onPressed` 콜백을 `showModalBottomSheet`를 호출하도록 수정합니다.
- [x] `showModalBottomSheet`의 `builder`에서 `CalendarBottomSheet` 위젯을 반환하도록 구현합니다.
- [x] 아이콘을 `Icons.calendar_today_outlined`로 고정합니다.
- [x] `HomeViewModel`의 `toggleCalendarView()` 호출 코드를 제거합니다.

## 4단계: `UnifiedCalendarWidget` 및 `HomeViewModel` 리팩토링

- [x] `unified_calendar.dart` 파일에서 `_GridView` 위젯과 관련 로직을 모두 제거합니다.
- [x] `AnimatedSwitcher`와 `AnimatedSize`를 제거하고, `_HorizontalView`만 남도록 구조를 단순화합니다.
- [x] `home_view_model.dart` 파일에서 `calendarViewMode` 상태 변수와 `toggleCalendarView()` 메서드를 제거합니다.
- [x] `CalendarViewMode` 열거형(`lib/core/constants/enum.dart`)을 삭제하거나 주석 처리합니다.

## 5단계: 검증 및 마무리

- [x] 앱을 실행하여 `AppBar`의 캘린더 아이콘을 탭했을 때 바텀시트가 정상적으로 나타나는지 확인합니다.
- [x] 바텀시트 내의 캘린더가 날짜 선택 및 월 이동과 같은 기존 기능을 모두 정상적으로 수행하는지 테스트합니다.
- [x] `dart_fix` 및 `flutter analyze`를 실행하여 코드 문제를 확인하고 수정합니다.
- [x] 모든 테스트를 다시 실행하여 회귀 오류가 없는지 확인합니다.
- [x] `dart_format`으로 코드 서식을 지정합니다.

## 최종 단계: 문서화 및 최종 검토

- [ ] `README.md` 또는 기타 관련 문서에 변경 사항이 있다면 업데이트합니다.
- [ ] `GEMINI.md` 파일을 검토하여 `UnifiedCalendarWidget` 및 `CalendarViewMode`에 대한 설명이 현재 구현과 일치하는지 확인하고, 필요하다면 수정합니다.
- [ ] 사용자에게 수정된 앱을 검토하고 최종 만족 여부를 확인해달라고 요청합니다.

---

## 작업 일지 (Journal)

*   **2025-10-12**:
    *   1단계 완료: `flutter test`를 실행하여 모든 테스트가 통과함을 확인했습니다.
    *   2단계 완료: `CalendarBottomSheet` 위젯을 생성하고 기존 `_GridView` 코드를 이전했습니다.
    *   3단계 완료: `HomeAppBar`를 수정하여 바텀시트를 열도록 변경했습니다.
    *   4단계 완료: `UnifiedCalendarWidget`, `HomeViewModel`, `enum.dart`에서 불필요해진 코드를 모두 제거했습니다.
    *   5단계 시작: `flutter analyze` 실행 후 발생한 `unused_import` 및 `deprecated_member_use` 경고를 수정했습니다. 수정 과정에서 실수로 필요한 import 문까지 제거하여 빌드 오류가 발생했으나, 다시 복원하여 해결했습니다. 모든 정적 분석 문제를 해결하고, 다시 테스트를 실행하여 통과함을 확인했습니다. `dart format`으로 코드 서식을 정리했습니다.

---

**참고:** 작업을 완료한 후 코드에 `TODO`를 추가했거나 완전히 구현되지 않은 부분이 있다면, 나중에 다시 돌아와 완료할 수 있도록 새 작업을 추가해야 합니다.
