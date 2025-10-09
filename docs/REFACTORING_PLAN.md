# MoodLog Flutter 리팩토링 계획

> 생성일: 2025-10-09
> 목적: 코드의 일관성 부족 문제 해결 및 Dart/Flutter 딥다이브

---

## 📊 현재 상태 분석

### 코드베이스 통계
- **총 파일 수**: 270개 Dart 파일
- **총 코드 라인**: 32,202줄
- **평균 파일 크기**: 119줄/파일
- **최대 파일**: `write_view_model.dart` (694줄)

### 발견된 주요 문제점

#### 1. 코드 품질 이슈
- ❌ Deprecated API 사용 (20+ 경고)
  - Radio 위젯의 `groupValue`/`onChanged` (14건)
  - Matrix4의 `translate`/`scale` (2건)
- ⚠️ BuildContext async gap 경고 (1건)
- ⚠️ 불필요한 import (4건)

#### 2. 아키텍처 일관성 부족
- 📁 문서는 `lib/common` 언급하지만 실제는 `lib/core` 사용
- 🏷️ ViewModel/Provider 명명 규칙 혼재
- 🔗 과도한 의존성
  - `WriteViewModel`: 11개 의존성
  - `HomeViewModel`: 3개 의존성

#### 3. 상태 관리 혼재
- ✅ 주로 ViewModel(ChangeNotifier) 사용 (13개)
- ⚠️ 일부 StatefulWidget에서 setState 사용 (9개 파일, 14건)
- ❌ 패턴 일관성 부족

#### 4. 파일 크기 불균형
| 파일 | 라인 수 |
|------|---------|
| `write_view_model.dart` | 694 |
| `statistics_view_model.dart` | 308 |
| `writing_frequency_card.dart` | 418 |
| `representative_mood_card.dart` | 364 |
| `average_mood_card.dart` | 324 |

---

## 🎯 Phase 1: 기초 정리

**기간**: 1-2일
**난이도**: ⭐ 낮음
**목표**: Dart 기초 익히기 & 빠른 개선

### 1.1 Deprecated API 교체

#### Radio 위젯 마이그레이션
```dart
// ❌ Before (deprecated)
Radio<T>(
  groupValue: selectedValue,
  onChanged: (value) => setState(() => selectedValue = value),
)

// ✅ After (권장)
// RadioGroup을 사용하거나 ViewModel로 상태 관리 이동
```

**영향 파일** (14건):
- `lib/presentation/settings/widgets/dialog/language_dialog.dart` (6건)
- `lib/presentation/settings/widgets/dialog/theme_dialog.dart` (6건)
- `lib/presentation/settings/widgets/dialog/font_family_dialog.dart` (2건)
- `lib/presentation/onboarding/widgets/onboarding_personality_item.dart` (2건)

#### Matrix4 API 마이그레이션
```dart
// ❌ Before (deprecated)
Matrix4.identity()
  ..translate(x, y)
  ..scale(s)

// ✅ After
Matrix4.identity()
  ..translateByVector3(Vector3(x, y, 0))
  ..scaleByVector3(Vector3(s, s, 1))
```

**영향 파일**:
- `lib/presentation/journal/image_detail_screen.dart` (2건)

### 1.2 Import 정리

**제거 대상**:
- Unused import: 3건
  - `journal_view.dart`: `Journal` entity
  - `tag_input_bottom_sheet.dart`: `provider` package
  - (테스트 파일 1건)
- Unnecessary import: 1건
  - `async_state_mixin.dart`: `foundation.dart`

### 1.3 문서 업데이트

**`CLAUDE.md` 수정**:
```diff
- Common: `lib/common`
+ Common: `lib/core`
```

### 검증 방법
```bash
flutter analyze  # 경고 0개 목표
```

---

## 🎯 Phase 2: 명명 규칙 통일

**기간**: 2-3일
**난이도**: ⭐ 낮음
**목표**: 일관성 확보 & Dart 컨벤션 학습

### 2.1 ViewModel vs Provider 명명 규칙

#### 확립된 규칙

| 타입 | 용도 | 명명 규칙 | 예시 |
|------|------|-----------|------|
| **ViewModel** | 화면별 상태 (특정 화면에 종속) | `{Feature}ViewModel` | `HomeViewModel`, `WriteViewModel` |
| **Provider** | 전역/공유 상태 (여러 화면 공유) | `{Feature}Provider` | `AppStateProvider`, `UserProvider` |

#### 현재 상태 (13개 파일 - 이미 올바름)

**ViewModels (화면별):**
```
✅ lib/presentation/write/write_view_model.dart
✅ lib/presentation/home/home_view_model.dart
✅ lib/presentation/journal/journal_view_model.dart
✅ lib/presentation/statistics/statistics_view_model.dart
✅ lib/presentation/settings/settings_view_model.dart
✅ lib/presentation/entries/entries_view_model.dart
✅ lib/presentation/auth/auth_view_model.dart
✅ lib/presentation/profile/profile_view_model.dart
✅ lib/presentation/base_layout/base_layout_view_model.dart
✅ lib/presentation/onboarding/onboarding_view_model.dart
```

**Providers (전역):**
```
✅ lib/presentation/providers/app_state_provider.dart
✅ lib/presentation/providers/user_provider.dart
✅ lib/presentation/providers/ai_generation_provider.dart
```

**결론**: 명명은 이미 일관됨. 추가 작업 불필요.

### 2.2 폴더 구조 표준화

#### 표준 패턴
```
lib/presentation/{feature}/
├── {feature}_view.dart          # 화면 (View)
├── {feature}_content.dart       # 콘텐츠 (있는 경우)
├── {feature}_view_model.dart    # ViewModel
└── widgets/                     # 피처별 위젯
    ├── {widget_name}.dart
    └── dialog/
        └── {dialog_name}.dart
```

#### 검토 항목
- [ ] 모든 feature가 표준 구조를 따르는지 확인
- [ ] 예외 케이스 문서화
- [ ] `lib/core/ui/widgets/`와 feature별 widgets 구분 명확화

---

## 🎯 Phase 3: 상태 관리 일관성

**기간**: 3-4일
**난이도**: ⭐⭐ 중간
**목표**: Flutter 상태 관리 패턴 깊이 학습

### 3.1 setState 제거

#### 작업 대상 (9개 파일, 14건)

**우선순위 1: 간단한 위젯** (1-2건)
1. ✅ `lib/presentation/base_layout/widgets/title_bar.dart` (1건)
2. ✅ `lib/presentation/profile/widgets/bottom_sheet/edit_display_name_bottom_sheet.dart` (1건)
3. ✅ `lib/presentation/profile/widgets/dialog/delete_account_form_dialog.dart` (1건)
4. ✅ `lib/presentation/settings/widgets/dialog/ai_personality_dialog.dart` (1건)
5. ✅ `lib/presentation/write/widgets/editor_bottom_panel.dart` (1건)
6. ✅ `lib/core/ui/widgets/native_ad_widget.dart` (1건)
7. ✅ `lib/core/ui/widgets/banner_ad_widget.dart` (1건)

**우선순위 2: 복잡한 위젯**
8. ⚠️ `lib/presentation/journal/widgets/journal_weather_widget.dart` (4건)
9. ⚠️ `lib/core/ui/widgets/scale_wrapper.dart` (3건)

#### 리팩토링 패턴

##### 패턴 A: 간단한 로컬 상태
```dart
// ❌ Before: StatefulWidget + setState
class TitleBar extends StatefulWidget {
  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  bool _isExpanded = false;

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggle,
      icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
    );
  }
}

// ✅ After: StatelessWidget + ChangeNotifier (간단한 경우)
class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _TitleBarState(),
      child: Consumer<_TitleBarState>(
        builder: (context, state, _) {
          return IconButton(
            onPressed: state.toggle,
            icon: Icon(state.isExpanded ? Icons.expand_less : Icons.expand_more),
          );
        },
      ),
    );
  }
}

class _TitleBarState extends ChangeNotifier {
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void toggle() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
```

##### 패턴 B: 복잡한 위젯 (ViewModel 분리)
```dart
// ❌ Before
class JournalWeatherWidget extends StatefulWidget {
  final WeatherInfo? weatherInfo;
  // ...
}

class _JournalWeatherWidgetState extends State<JournalWeatherWidget> {
  bool _isExpanded = false;
  String _selectedView = 'detail';
  // ... 복잡한 로직

  @override
  Widget build(BuildContext context) {
    // ... 복잡한 UI
  }
}

// ✅ After
// 1. ViewModel 분리
class JournalWeatherViewModel extends ChangeNotifier {
  bool _isExpanded = false;
  String _selectedView = 'detail';

  bool get isExpanded => _isExpanded;
  String get selectedView => _selectedView;

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  void changeView(String view) {
    _selectedView = view;
    notifyListeners();
  }
}

// 2. StatelessWidget으로 변환
class JournalWeatherWidget extends StatelessWidget {
  final WeatherInfo? weatherInfo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JournalWeatherViewModel(),
      child: _JournalWeatherContent(weatherInfo: weatherInfo),
    );
  }
}

class _JournalWeatherContent extends StatelessWidget {
  final WeatherInfo? weatherInfo;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<JournalWeatherViewModel>();
    // ... UI 구성
  }
}
```

##### 패턴 C: 애니메이션 위젯 (예외 허용)
```dart
// ⚠️ 특별한 경우: AnimationController가 필요한 경우
// StatefulWidget + setState 유지 가능
// 단, 비즈니스 로직은 ViewModel로 분리

class ScaleWrapper extends StatefulWidget {
  // AnimationController 필요 → StatefulWidget 유지
  // 하지만 상태 로직은 최소화
}
```

### 3.2 AsyncStateMixin 활용 표준화

#### 현재 사용 중 (10개 파일)
```
✅ lib/core/mixins/async_state_mixin.dart (정의)
✅ lib/presentation/write/write_view_model.dart
✅ lib/presentation/home/home_view_model.dart
✅ lib/presentation/journal/journal_view_model.dart
✅ lib/presentation/statistics/statistics_view_model.dart
✅ lib/presentation/settings/settings_view_model.dart
✅ lib/presentation/entries/entries_view_model.dart
✅ lib/presentation/onboarding/onboarding_view_model.dart
✅ lib/presentation/providers/app_state_provider.dart
✅ lib/presentation/providers/ai_generation_provider.dart
```

#### 표준 패턴
```dart
class SomeViewModel extends ChangeNotifier with AsyncStateMixin {
  // 1. 데이터 로딩
  Future<void> loadData() async {
    setLoading();  // 로딩 상태 시작
    try {
      final result = await repository.fetchData();
      _data = result;
      setSuccess();  // 성공 상태
    } catch (e) {
      setError(e);  // 에러 상태
    }
  }

  // 2. UI에서 상태 확인
  // isLoading, isSuccess, isError 게터 사용

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SomeViewModel>();

    if (viewModel.isLoading) {
      return CircularProgressIndicator();
    }

    if (viewModel.isError) {
      return ErrorWidget(viewModel.errorMessage);
    }

    return SuccessView(viewModel.data);
  }
}
```

#### 개선 사항
- [ ] BuildContext async gap 경고 해결
  - `async_state_mixin.dart:119` 확인
  - `mounted` 체크 추가 또는 구조 개선

### 검증 방법
```bash
# 각 파일 수정 후
flutter analyze
flutter test

# UI 동작 확인
flutter run
```

---

## 🎯 Phase 4: ViewModel 의존성 리팩토링

**기간**: 5-7일
**난이도**: ⭐⭐⭐ 높음
**목표**: Clean Architecture 실전 적용

### 4.1 과도한 의존성 분석

#### WriteViewModel (11개 의존성)

```dart
class WriteViewModel extends ChangeNotifier with AsyncStateMixin {
  WriteViewModel({
    // 그룹 1: AI 관련 (3개)
    required GeminiUseCase geminiUseCase,
    required AiGenerationProvider aiGenerationProvider,
    required CheckAiUsageLimitUseCase checkAiUsageLimitUseCase,

    // 그룹 2: 위치/날씨 (2개)
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,

    // 그룹 3: 저널 CRUD (1개)
    required JournalUseCase journalUseCase,

    // 그룹 4: 미디어/태그 (2개)
    required PickImageUseCase pickImageUseCase,
    required TagUseCase tagUseCase,

    // 그룹 5: 기타 (3개)
    required AppStateProvider appStateProvider,
    required SettingsUseCase settingsUseCase,
    required LogMoodEntryUseCase logMoodEntryUseCase,
  })
}
```

### 4.2 리팩토링 전략

#### 전략 1: Facade 패턴으로 UseCase 통합

```dart
// ❌ Before: 3개의 AI 관련 의존성
class WriteViewModel {
  final GeminiUseCase _geminiUseCase;
  final AiGenerationProvider _aiGenerationProvider;
  final CheckAiUsageLimitUseCase _checkAiUsageLimitUseCase;

  Future<void> generateAiResponse() async {
    // 여러 UseCase 조율
    final canUse = await _checkAiUsageLimitUseCase.execute();
    if (!canUse) return;

    _aiGenerationProvider.setGenerating(true);
    final response = await _geminiUseCase.generate(prompt);
    _aiGenerationProvider.setGenerating(false);
  }
}

// ✅ After: 1개의 통합 UseCase (Facade)
class AiFeatureFacade {
  final GeminiUseCase _geminiUseCase;
  final AiGenerationProvider _aiGenerationProvider;
  final CheckAiUsageLimitUseCase _checkAiUsageLimitUseCase;

  AiFeatureFacade({
    required GeminiUseCase geminiUseCase,
    required AiGenerationProvider aiGenerationProvider,
    required CheckAiUsageLimitUseCase checkAiUsageLimitUseCase,
  }) : _geminiUseCase = geminiUseCase,
       _aiGenerationProvider = aiGenerationProvider,
       _checkAiUsageLimitUseCase = checkAiUsageLimitUseCase;

  Future<Result<String>> generateResponse(String prompt) async {
    // 내부에서 모든 AI 관련 로직 처리
    final canUse = await _checkAiUsageLimitUseCase.execute();
    if (!canUse) {
      return Result.error(Exception('AI 사용 제한 초과'));
    }

    _aiGenerationProvider.setGenerating(true);
    try {
      final response = await _geminiUseCase.generate(prompt);
      return Result.ok(response);
    } finally {
      _aiGenerationProvider.setGenerating(false);
    }
  }

  Stream<AiGenerationState> get generationState =>
      _aiGenerationProvider.stateStream;
}

// WriteViewModel은 1개만 의존
class WriteViewModel {
  final AiFeatureFacade _aiFeature;

  Future<void> generateAiResponse() async {
    final result = await _aiFeature.generateResponse(_content);
    result.when(
      ok: (response) => _handleAiResponse(response),
      error: (error) => _handleError(error),
    );
  }
}
```

#### 전략 2: Coordinator 패턴으로 관련 기능 통합

```dart
// ❌ Before: 위치와 날씨를 개별 관리
class WriteViewModel {
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;

  Future<void> loadLocationAndWeather() async {
    final location = await _getCurrentLocationUseCase.execute();
    _locationInfo = location;

    final weather = await _weatherUseCase.getWeather(location);
    _weatherInfo = weather;
  }
}

// ✅ After: Coordinator로 통합
class LocationWeatherCoordinator {
  final GetCurrentLocationUseCase _locationUseCase;
  final WeatherUseCase _weatherUseCase;

  LocationWeatherCoordinator({
    required GetCurrentLocationUseCase locationUseCase,
    required WeatherUseCase weatherUseCase,
  }) : _locationUseCase = locationUseCase,
       _weatherUseCase = weatherUseCase;

  // 복합 작업을 하나의 메서드로
  Future<Result<LocationWeatherData>> getCurrentLocationWithWeather() async {
    try {
      final location = await _locationUseCase.execute();
      if (location.isError) {
        return Result.error(location.error);
      }

      final weather = await _weatherUseCase.getWeather(location.value);
      if (weather.isError) {
        return Result.error(weather.error);
      }

      return Result.ok(LocationWeatherData(
        location: location.value,
        weather: weather.value,
      ));
    } catch (e) {
      return Result.error(Exception('위치/날씨 정보 로드 실패: $e'));
    }
  }
}

// WriteViewModel은 간단해짐
class WriteViewModel {
  final LocationWeatherCoordinator _locationWeatherCoordinator;

  Future<void> loadLocationAndWeather() async {
    setLoading();
    final result = await _locationWeatherCoordinator.getCurrentLocationWithWeather();
    result.when(
      ok: (data) {
        _locationInfo = data.location;
        _weatherInfo = data.weather;
        setSuccess();
      },
      error: (error) => setError(error),
    );
  }
}
```

### 4.3 리팩토링 후 목표 구조

```dart
// 🎯 목표: 11개 → 5-6개 의존성
class WriteViewModel extends ChangeNotifier with AsyncStateMixin {
  WriteViewModel({
    required AiFeatureFacade aiFeature,                // 1. AI 통합
    required LocationWeatherCoordinator locationWeather, // 2. 위치/날씨 통합
    required JournalUseCase journalUseCase,            // 3. 저널 CRUD
    required MediaTagCoordinator mediaTag,             // 4. 이미지/태그 통합
    required AppStateProvider appStateProvider,        // 5. 전역 상태
    required AnalyticsUseCase analyticsUseCase,        // 6. 분석/로깅 통합
  })
}
```

### 4.4 DI 컨테이너 업데이트

`lib/core/di/injection_container.dart`에 새로운 Facade/Coordinator 등록:

```dart
List<SingleChildWidget> _createUseCases() {
  return [
    // 기존 UseCase들...

    // 새로운 Facade/Coordinator
    Provider<AiFeatureFacade>(
      create: (context) => AiFeatureFacade(
        geminiUseCase: context.read(),
        aiGenerationProvider: context.read(),
        checkAiUsageLimitUseCase: context.read(),
      ),
    ),

    Provider<LocationWeatherCoordinator>(
      create: (context) => LocationWeatherCoordinator(
        locationUseCase: context.read(),
        weatherUseCase: context.read(),
      ),
    ),

    Provider<MediaTagCoordinator>(
      create: (context) => MediaTagCoordinator(
        pickImageUseCase: context.read(),
        tagUseCase: context.read(),
      ),
    ),
  ];
}
```

### 4.5 단계별 마이그레이션

1. **단계 1**: Facade/Coordinator 클래스 생성
2. **단계 2**: DI 컨테이너에 등록
3. **단계 3**: WriteViewModel을 복사하여 새 버전 작성
4. **단계 4**: 테스트 후 기존 코드 교체
5. **단계 5**: 다른 ViewModel에도 패턴 적용

---

## 🎯 Phase 5: 코드 분할 & 품질 개선

**기간**: 지속적
**난이도**: ⭐⭐ 중간
**목표**: 유지보수성 향상

### 5.1 큰 파일 분할 (500줄 이상)

#### 작업 대상

| 파일 | 라인 수 | 우선순위 |
|------|---------|----------|
| `write_view_model.dart` | 694 | 🔴 높음 |
| `writing_frequency_card.dart` | 418 | 🟡 중간 |
| `representative_mood_card.dart` | 364 | 🟡 중간 |
| `average_mood_card.dart` | 324 | 🟡 중간 |
| `statistics_view_model.dart` | 308 | 🟡 중간 |

#### 전략: Mixin을 활용한 분할

##### WriteViewModel 분할 예시

```dart
// ❌ Before: 694줄의 거대한 ViewModel
class WriteViewModel extends ChangeNotifier with AsyncStateMixin {
  // AI 관련 (100줄)
  Future<void> generateAiResponse() { ... }
  Future<void> checkAiLimit() { ... }

  // 위치/날씨 (80줄)
  Future<void> loadLocation() { ... }
  Future<void> loadWeather() { ... }

  // 이미지 (60줄)
  Future<void> pickImage() { ... }
  void removeImage(int index) { ... }

  // 태그 (50줄)
  Future<void> loadTags() { ... }
  void addTag(Tag tag) { ... }

  // 저널 CRUD (200줄)
  Future<void> saveJournal() { ... }
  Future<void> updateJournal() { ... }

  // 기타 (204줄)
  // ...
}

// ✅ After: Mixin으로 기능별 분할

// 1. write_view_model.dart (메인, ~200줄)
class WriteViewModel extends ChangeNotifier
    with AsyncStateMixin,
         WriteAiFeatureMixin,
         WriteLocationWeatherMixin,
         WriteImageMixin,
         WriteTagMixin {

  // 코어 로직만 유지
  final JournalUseCase _journalUseCase;

  MoodType _selectedMood = MoodType.neutral;
  DateTime _selectedDate;
  String? _content;

  // 저널 저장/업데이트 핵심 로직
  Future<void> saveJournal() async {
    setLoading();
    try {
      final request = _buildJournalRequest();
      final result = await _journalUseCase.createJournal(request);
      setSuccess();
    } catch (e) {
      setError(e);
    }
  }

  CreateJournalRequest _buildJournalRequest() {
    return CreateJournalRequest(
      mood: _selectedMood,
      content: _content,
      date: _selectedDate,
      images: selectedImageList,  // from WriteImageMixin
      tags: selectedTags,         // from WriteTagMixin
      location: locationInfo,     // from WriteLocationWeatherMixin
      weather: weatherInfo,       // from WriteLocationWeatherMixin
      aiResponse: aiResponse,     // from WriteAiFeatureMixin
    );
  }
}

// 2. write_ai_feature_mixin.dart (~100줄)
mixin WriteAiFeatureMixin on ChangeNotifier {
  final AiFeatureFacade _aiFeature;

  bool _aiEnabled = true;
  String? _aiResponse;

  bool get aiEnabled => _aiEnabled;
  String? get aiResponse => _aiResponse;

  Future<void> generateAiResponse(String content) async {
    if (!_aiEnabled) return;

    final result = await _aiFeature.generateResponse(content);
    result.when(
      ok: (response) {
        _aiResponse = response;
        notifyListeners();
      },
      error: (error) {
        // 에러 처리
      },
    );
  }

  void toggleAiEnabled() {
    _aiEnabled = !_aiEnabled;
    notifyListeners();
  }
}

// 3. write_location_weather_mixin.dart (~80줄)
mixin WriteLocationWeatherMixin on ChangeNotifier {
  final LocationWeatherCoordinator _coordinator;

  LocationInfo? _locationInfo;
  WeatherInfo? _weatherInfo;
  bool _isLoadingLocation = false;

  LocationInfo? get locationInfo => _locationInfo;
  WeatherInfo? get weatherInfo => _weatherInfo;
  bool get isLoadingLocation => _isLoadingLocation;

  Future<void> loadLocationAndWeather() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _coordinator.getCurrentLocationWithWeather();
    result.when(
      ok: (data) {
        _locationInfo = data.location;
        _weatherInfo = data.weather;
      },
      error: (error) {
        // 에러 처리
      },
    );

    _isLoadingLocation = false;
    notifyListeners();
  }
}

// 4. write_image_mixin.dart (~60줄)
mixin WriteImageMixin on ChangeNotifier {
  final PickImageUseCase _pickImageUseCase;

  List<String> _selectedImageList = [];

  List<String> get selectedImageList => _selectedImageList;

  Future<void> pickImage() async {
    final result = await _pickImageUseCase.execute();
    result.when(
      ok: (imagePath) {
        _selectedImageList.add(imagePath);
        notifyListeners();
      },
      error: (error) {
        // 에러 처리
      },
    );
  }

  void removeImage(int index) {
    _selectedImageList.removeAt(index);
    notifyListeners();
  }
}

// 5. write_tag_mixin.dart (~50줄)
mixin WriteTagMixin on ChangeNotifier {
  final TagUseCase _tagUseCase;

  List<Tag> _availableTags = [];
  List<Tag> _selectedTags = [];

  List<Tag> get availableTags => _availableTags;
  List<Tag> get selectedTags => _selectedTags;

  Future<void> loadAvailableTags() async {
    final result = await _tagUseCase.getTags();
    result.when(
      ok: (tags) {
        _availableTags = tags;
        notifyListeners();
      },
      error: (error) {
        // 에러 처리
      },
    );
  }

  void toggleTag(Tag tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notifyListeners();
  }
}
```

**장점:**
- 각 Mixin은 단일 책임
- 테스트 용이
- 재사용 가능
- 파일 크기 관리

### 5.2 위젯 컴포지션 개선

#### 원칙
1. **100줄 이상 build 메서드 → 서브 위젯으로 분리**
2. **재사용 가능한 패턴 추출**
3. **공통 위젯은 `lib/core/ui/widgets/`에 배치**

#### 예시: 복잡한 통계 카드 분할

```dart
// ❌ Before: 418줄의 거대한 위젯
class WritingFrequencyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // 헤더 (50줄)
          _buildHeader(),
          // 차트 (200줄)
          _buildChart(),
          // 범례 (100줄)
          _buildLegend(),
          // 통계 (68줄)
          _buildStats(),
        ],
      ),
    );
  }

  Widget _buildHeader() { /* 50줄 */ }
  Widget _buildChart() { /* 200줄 */ }
  Widget _buildLegend() { /* 100줄 */ }
  Widget _buildStats() { /* 68줄 */ }
}

// ✅ After: 작은 위젯들로 분할

// 1. writing_frequency_card.dart (메인, ~50줄)
class WritingFrequencyCard extends StatelessWidget {
  final List<FrequencyData> data;

  @override
  Widget build(BuildContext context) {
    return BaseStatisticCard(
      title: '작성 빈도',
      child: Column(
        children: [
          FrequencyChart(data: data),
          FrequencyLegend(data: data),
          FrequencyStats(data: data),
        ],
      ),
    );
  }
}

// 2. frequency_chart.dart (~150줄)
class FrequencyChart extends StatelessWidget {
  final List<FrequencyData> data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: FlChart(
        // 차트 구성
      ),
    );
  }
}

// 3. frequency_legend.dart (~80줄)
class FrequencyLegend extends StatelessWidget {
  final List<FrequencyData> data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: data.map((item) => LegendItem(item)).toList(),
    );
  }
}

// 4. frequency_stats.dart (~60줄)
class FrequencyStats extends StatelessWidget {
  final List<FrequencyData> data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatItem(label: '평균', value: _calculateAverage()),
        StatItem(label: '최대', value: _calculateMax()),
      ],
    );
  }
}

// 5. lib/core/ui/widgets/base_statistic_card.dart (재사용)
class BaseStatisticCard extends StatelessWidget {
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
```

### 5.3 코드 품질 체크리스트

#### 파일 레벨
- [ ] 파일 크기 300줄 이하
- [ ] 단일 책임 원칙 준수
- [ ] 명확한 파일/클래스 명명
- [ ] 적절한 주석 (복잡한 로직만)

#### 클래스 레벨
- [ ] 클래스 크기 200줄 이하
- [ ] public 메서드 10개 이하
- [ ] 의존성 5-6개 이하
- [ ] 순환 의존성 없음

#### 메서드 레벨
- [ ] 메서드 크기 30줄 이하
- [ ] 파라미터 4개 이하
- [ ] 중첩 깊이 3 이하
- [ ] 명확한 메서드 이름

#### 위젯 레벨
- [ ] build 메서드 100줄 이하
- [ ] 위젯 트리 깊이 적절
- [ ] const 생성자 활용
- [ ] 불필요한 재빌드 방지

---

## 📚 학습 로드맵

### Week 1-2: Phase 1 (난이도: ⭐ 쉬움)

**학습 목표:**
- Dart 기본 문법 익히기
- Flutter CLI 도구 사용법
- Deprecated API 마이그레이션 경험

**추천 자료:**
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

**실습:**
1. `flutter analyze` 실행 및 결과 이해
2. Deprecated API 하나씩 교체
3. 각 변경사항 git commit

### Week 3-4: Phase 2 (난이도: ⭐ 쉬움)

**학습 목표:**
- Dart 프로젝트 구조 이해
- 파일/폴더 명명 컨벤션
- 코드 구조 분석 능력

**추천 자료:**
- [Flutter Project Structure Best Practices](https://docs.flutter.dev/development/tools/formatting)

**실습:**
1. 현재 프로젝트 구조 다이어그램 작성
2. 명명 규칙 문서화
3. 표준 패턴 적용

### Week 5-7: Phase 3 (난이도: ⭐⭐ 중간)

**학습 목표:**
- Flutter 상태 관리 깊이 이해
- Provider 패턴 마스터
- ChangeNotifier 활용
- Mixin 패턴 이해

**추천 자료:**
- [Provider Documentation](https://pub.dev/packages/provider)
- [Flutter State Management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)
- [Dart Mixins](https://dart.dev/guides/language/language-tour#adding-features-to-a-class-mixins)

**실습:**
1. StatefulWidget → StatelessWidget + ViewModel 변환
2. AsyncStateMixin 패턴 적용
3. 상태 관리 플로우 이해

### Week 8-12: Phase 4 (난이도: ⭐⭐⭐ 어려움)

**학습 목표:**
- Clean Architecture 이해
- SOLID 원칙
- Dependency Injection
- UseCase 패턴
- Facade/Coordinator 패턴

**추천 자료:**
- [Clean Architecture (Robert C. Martin)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)

**실습:**
1. Facade 패턴으로 UseCase 통합
2. Coordinator 패턴 구현
3. DI 컨테이너 개선
4. 점진적 리팩토링

### Continuous: Phase 5

**학습 목표:**
- 코드 리뷰 습관
- 리팩토링 감각
- 품질 기준 내재화

**추천 자료:**
- [Refactoring (Martin Fowler)](https://refactoring.com/)
- [Clean Code (Robert C. Martin)](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)

**실습:**
1. 매일 코드 리뷰
2. 작은 리팩토링 지속
3. 베스트 프랙티스 적용

---

## ✅ 검증 방법

### 각 Phase 완료 시

```bash
# 1. 코드 분석
flutter analyze

# 2. 테스트 실행
flutter test

# 3. 빌드 확인
flutter build apk --debug

# 4. 실행 및 동작 확인
flutter run
```

### 목표 지표

| 항목 | 현재 | 목표 |
|------|------|------|
| flutter analyze 경고 | 25+ | 0 |
| 평균 파일 크기 | 119줄 | 유지 |
| 최대 파일 크기 | 694줄 | 300줄 이하 |
| ViewModel 평균 의존성 | 8개 | 5개 이하 |
| setState 사용 | 14건 | 3건 이하 (애니메이션만) |

---

## 🔒 안전한 리팩토링 전략

### 1. Git 브랜치 전략

```bash
# 각 Phase별로 브랜치 생성
git checkout -b refactor/phase-1-basic-cleanup
git checkout -b refactor/phase-2-naming-convention
git checkout -b refactor/phase-3-state-management
git checkout -b refactor/phase-4-dependency-refactoring
```

### 2. 작은 단위로 커밋

```bash
# 좋은 커밋 예시
git commit -m "refactor: Radio deprecated API 교체 - language_dialog"
git commit -m "refactor: Matrix4.translate → translateByVector3"
git commit -m "refactor: unnecessary import 제거 - async_state_mixin"

# 나쁜 커밋 예시 (피할 것)
git commit -m "refactor: 여러 파일 수정"
git commit -m "fix stuff"
```

### 3. 리팩토링 체크리스트

파일 수정 전:
- [ ] 현재 동작하는 코드임을 확인
- [ ] 테스트가 있다면 실행하여 통과 확인
- [ ] 변경 범위 명확히 정의

파일 수정 후:
- [ ] `flutter analyze` 실행
- [ ] 관련 테스트 실행
- [ ] 수동 동작 확인
- [ ] Git commit
- [ ] 다음 파일로 이동

### 4. 롤백 준비

```bash
# Phase 시작 전 백업 브랜치
git checkout -b backup/before-phase-3
git checkout refactor/phase-3-state-management

# 문제 발생 시 롤백
git checkout backup/before-phase-3
git branch -D refactor/phase-3-state-management
```

### 5. 점진적 마이그레이션

```dart
// ❌ 한 번에 모든 파일 수정 (위험)
// 모든 ViewModel을 동시에 리팩토링

// ✅ 하나씩 점진적으로 (안전)
// 1. HomeViewModel 리팩토링
// 2. 테스트 및 동작 확인
// 3. commit
// 4. WriteViewModel 리팩토링
// 5. 반복...
```

### 6. Feature Flag 활용 (필요시)

```dart
// 큰 변경사항은 feature flag로 보호
class FeatureFlags {
  static const bool useNewStateManagement = false;
}

Widget build(BuildContext context) {
  if (FeatureFlags.useNewStateManagement) {
    return NewImplementation();
  }
  return OldImplementation();
}
```

---

## 📊 예상 효과

### 정량적 개선

| 지표 | Before | After | 개선율 |
|------|--------|-------|--------|
| Deprecated 경고 | 20+ | 0 | 100% ↓ |
| Import 경고 | 4 | 0 | 100% ↓ |
| 최대 파일 크기 | 694줄 | 300줄 | 57% ↓ |
| ViewModel 평균 의존성 | 8개 | 5개 | 38% ↓ |
| setState 사용 | 14건 | 3건 | 79% ↓ |
| 코드 일관성 점수 | 60% | 95% | 58% ↑ |

### 정성적 개선

#### 코드 품질
- ✅ 일관된 코드 스타일 및 패턴
- ✅ 명확한 아키텍처 구조
- ✅ 높은 가독성
- ✅ 쉬운 유지보수
- ✅ Dart/Flutter 베스트 프랙티스 준수

#### 개발 경험
- ✅ 새로운 기능 추가 용이
- ✅ 버그 발견 및 수정 빠름
- ✅ 팀 협업 가능
- ✅ 코드 리뷰 효율 향상
- ✅ 테스트 작성 용이

#### 학습 효과
- 📚 Dart 언어 완전 이해
- 📚 Flutter 프레임워크 마스터
- 📚 상태 관리 패턴 숙달
- 📚 Clean Architecture 실전 경험
- 📚 리팩토링 스킬 향상
- 📚 코드 품질 감각 형성
- 📚 소프트웨어 설계 능력 증진

---

## 📝 진행 상황 추적

### Phase별 체크리스트

#### Phase 1: 기초 정리
- [ ] Radio deprecated API 교체 (14건)
- [ ] Matrix4 deprecated API 교체 (2건)
- [ ] Unused import 제거 (3건)
- [ ] Unnecessary import 제거 (1건)
- [ ] CLAUDE.md 문서 업데이트
- [ ] `flutter analyze` 경고 0개 달성

#### Phase 2: 명명 규칙 통일
- [ ] ViewModel/Provider 명명 규칙 문서화
- [ ] 폴더 구조 표준 패턴 정의
- [ ] 예외 케이스 문서화
- [ ] 모든 feature 구조 검토 완료

#### Phase 3: 상태 관리 일관성
- [ ] title_bar.dart setState 제거
- [ ] edit_display_name_bottom_sheet.dart setState 제거
- [ ] delete_account_form_dialog.dart setState 제거
- [ ] ai_personality_dialog.dart setState 제거
- [ ] editor_bottom_panel.dart setState 제거
- [ ] native_ad_widget.dart setState 제거
- [ ] banner_ad_widget.dart setState 제거
- [ ] journal_weather_widget.dart setState 제거 (복잡)
- [ ] scale_wrapper.dart setState 검토 (애니메이션)
- [ ] AsyncStateMixin BuildContext 경고 해결

#### Phase 4: ViewModel 의존성 리팩토링
- [ ] AiFeatureFacade 구현
- [ ] LocationWeatherCoordinator 구현
- [ ] MediaTagCoordinator 구현
- [ ] DI 컨테이너 업데이트
- [ ] WriteViewModel 리팩토링 (11개 → 5개)
- [ ] 다른 ViewModel 리팩토링
- [ ] 테스트 작성/업데이트

#### Phase 5: 코드 분할 & 품질 개선
- [ ] write_view_model.dart Mixin 분할
- [ ] statistics_view_model.dart 분할
- [ ] writing_frequency_card.dart 분할
- [ ] representative_mood_card.dart 분할
- [ ] average_mood_card.dart 분할
- [ ] 공통 위젯 core로 이동
- [ ] 코드 품질 체크리스트 적용

---

## 🎓 참고 자료

### 공식 문서
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)

### 아키텍처 & 패턴
- [Clean Architecture (Robert C. Martin)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [Facade Pattern](https://refactoring.guru/design-patterns/facade)

### 리팩토링
- [Refactoring (Martin Fowler)](https://refactoring.com/)
- [Clean Code (Robert C. Martin)](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)

### 상태 관리
- [Flutter State Management Introduction](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)
- [Simple app state management (Provider)](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple)

---

## 💡 추가 팁

### 1. IDE 활용
- Android Studio / VSCode Flutter 플러그인 설치
- Dart Analysis 활성화
- Auto-format on save 설정
- Quick Fix 단축키 활용

### 2. 코드 리뷰
- 매일 작성한 코드 스스로 리뷰
- "이 코드를 6개월 후에 읽을 수 있을까?" 질문
- "다른 개발자가 이해할 수 있을까?" 확인

### 3. 학습 노트
- 새로 배운 패턴 기록
- 실수한 부분 정리
- 좋은 코드 예시 수집

### 4. 커뮤니티 활용
- [Flutter Community](https://flutter.dev/community)
- [r/FlutterDev](https://www.reddit.com/r/FlutterDev/)
- [Flutter Discord](https://discord.gg/flutter)

---

**Last Updated**: 2025-10-09
**Version**: 1.0
**Status**: 📝 계획 수립 완료