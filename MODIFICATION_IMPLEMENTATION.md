# 수정 구현 계획 (v2): 캘린더 바텀시트 기능 확장

이 문서는 `CalendarBottomSheet`에 선택된 날짜의 일기 목록을 표시하고, 홈 화면과 상태를 분리하는 기능 확장의 단계별 구현 계획을 설명합니다.

## 1단계: `JournalCard` 위젯 수정

- [x] `lib/core/ui/widgets/journal_card.dart` 파일을 엽니다.
- [x] `JournalCard` 생성자에 `final bool isCompact;` 필드를 추가하고, 기본값을 `false`로 설정합니다.
- [x] `build` 메서드 내에서 `isCompact` 값에 따라 패딩, 폰트 크기, 이미지 높이 등 UI 요소들의 크기를 조건부로 조절하는 로직을 추가합니다.
    - 예: `padding: isCompact ? Spacing.md : Spacing.xl`
    - 예: `style: isCompact ? textTheme.bodySmall : textTheme.bodyMedium`
- [x] 기존에 `JournalCard`를 사용하던 홈 화면(`journal_sliver_list.dart`)에서는 `isCompact` 값을 설정하지 않아도 기본값(`false`)으로 동작하는지 확인합니다.

## 2단계: `CalendarBottomSheet` 상태 및 UI 변경

- [x] `lib/presentation/screens/home/widgets/calendar_bottom_sheet.dart` 파일을 엽니다.
- [x] `CalendarBottomSheet`를 `StatelessWidget`에서 `StatefulWidget`으로 변경합니다.
- [x] `_CalendarBottomSheetState`를 생성하고, 내부에 `late DateTime _selectedInSheet;` 상태 변수를 선언합니다.
- [x] `initState`에서 `_selectedInSheet = context.read<HomeViewModel>().selectedDate;` 코드로 상태를 초기화합니다.
- [x] `TableCalendar`의 `onDaySelected` 콜백이 `setState(() { _selectedInSheet = selectedDay; });`를 호출하도록 수정합니다. `focusedDay`도 `_selectedInSheet`를 사용하도록 변경합니다.
- [x] `build` 메서드의 `Column` 위젯 내부에 `TableCalendar` 아래로 `Expanded`와 `ListView.builder`를 사용하여 일기 목록을 표시할 UI를 추가합니다.
- [x] `HomeViewModel`의 `yearlyJournals`에서 `_selectedInSheet` 날짜에 해당하는 일기 목록을 가져옵니다.
- [x] 가져온 일기 목록을 `ListView.builder`를 통해 `JournalCard(isCompact: true, ...)` 위젯으로 렌더링합니다.
- [x] 선택된 날짜에 일기가 없을 경우를 대비하여 `EmptyEntriesBox`와 유사한 위젯이나 간단한 텍스트 메시지를 표시하는 로직을 추가합니다.

## 3단계: 검증 및 마무리

- [x] 앱을 실행하여 `AppBar`의 캘린더 아이콘을 탭하여 바텀시트를 엽니다.
- [x] 바텀시트 내에서 날짜를 선택했을 때, 하단에 해당 날짜의 일기 목록이 작은 카드 형태로 정상적으로 표시되는지 확인합니다.
- [x] 일기가 없는 날짜를 선택했을 때 "일기가 없습니다"와 같은 메시지가 잘 보이는지 확인합니다.
- [x] 바텀시트 내에서 날짜를 변경해도 홈 화면의 날짜나 일기 목록은 변경되지 않는지 확인합니다.
- [x] 바텀시트를 닫고 다시 열었을 때, 처음에는 홈 화면의 날짜를 기준으로 열리는지 확인합니다.
- [x] `dart_fix` 및 `flutter analyze`를 실행하여 코드 문제를 확인하고 수정합니다.
- [x] 모든 테스트를 다시 실행하여 회귀 오류가 없는지 확인합니다.
- [x] `dart_format`으로 코드 서식을 지정합니다.

## 최종 단계: 문서화 및 최종 검토

- [ ] `README.md` 또는 기타 관련 문서에 변경 사항이 있다면 업데이트합니다.
- [ ] `GEMINI.md` 파일을 검토하여 `CalendarBottomSheet`의 새로운 기능과 상태 관리에 대한 설명이 추가되었는지 확인하고, 필요하다면 수정합니다.
- [ ] 사용자에게 수정된 앱을 검토하고 최종 만족 여부를 확인해달라고 요청합니다.

---

## 작업 일지 (Journal)

*   **2025-10-12**:
    *   1단계 완료: `JournalCard`에 `isCompact` 옵션을 추가하여 작은 버전의 카드를 만들 수 있도록 수정했습니다. `TagChip`도 함께 수정했습니다.
    *   2단계 완료: `CalendarBottomSheet`를 `StatefulWidget`으로 변환하고, 독립적인 날짜 상태(`_selectedInSheet`)를 추가했습니다. 캘린더 하단에 `isCompact: true`가 적용된 `JournalCard` 목록을 표시하는 UI를 구현했습니다.
    *   3단계 시작: `flutter analyze`를 실행하여 발생한 `unused_import` 경고를 수정했습니다. 모든 테스트가 통과하는 것을 확인하고, `dart format`으로 코드 서식을 정리했습니다.

---

**참고:** 작업을 완료한 후 코드에 `TODO`를 추가했거나 완전히 구현되지 않은 부분이 있다면, 나중에 다시 돌아와 완료할 수 있도록 새 작업을 추가해야 합니다.
