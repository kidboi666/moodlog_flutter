# 앱 초기화 구조 개선 계획

> 생성일: 2025-10-14
> 우선순위: 중간
> 난이도: ⭐ 낮음

---

## 📋 개요

현재 앱 시작 시 초기화 로직이 3개의 컴포넌트에 분산되어 있어 불필요하게 복잡한 구조를 가지고 있습니다. 이를 단순화하여 유지보수성과 가독성을 개선합니다.

## 🔍 현재 문제점

### 복잡한 초기화 흐름

```
main.dart
  └─ AppInitializer (초기화 준비 단계)
      ├─ loadSettings()
      ├─ onAppStarted 콜백 생성
      └─ build: MoodLogApp
          ├─ onAppStarted 전달
          └─ builder: AppStartupLogic (콜백 실행)
              └─ didChangeDependencies에서 onAppStarted 실행
                  └─ DataSeedingService 실행
```

### 구체적인 문제

1. **불필요한 콜백 체인**
   - `AppInitializer`에서 `onAppStarted` 콜백을 생성
   - `MoodLogApp`이 이 콜백을 단순히 전달만 함
   - `AppStartupLogic`이 `didChangeDependencies`에서 콜백을 실행
   - 콜백이 3단계를 거쳐 전달되어 추적이 어려움

2. **책임 분산**
   - `AppInitializer`: Settings 로드
   - `AppStartupLogic`: 데이터 시딩 실행
   - 관련된 초기화 로직이 2곳에 분리됨

3. **코드 복잡도**
   - `MoodLogApp`이 초기화 로직을 중개하는 역할만 수행
   - `builder` 파라미터에서 `AppStartupLogic` 래핑
   - 불필요한 보일러플레이트 코드

## ✅ 개선 방안

### 단순화된 구조

```
main.dart
  └─ AppInitializer (모든 초기화 처리)
      ├─ loadSettings()
      ├─ DataSeedingService 직접 실행
      └─ build: MoodLogApp (순수하게 앱 설정만)
```

### 장점

1. **명확한 책임 분리**
   - `AppInitializer`: 모든 앱 초기화 담당
   - `MoodLogApp`: 라우팅, 테마, 로컬라이제이션 설정만 담당

2. **가독성 향상**
   - 초기화 로직이 한 곳에 집중됨
   - 콜백 체인 제거로 코드 흐름 추적 용이

3. **유지보수성 향상**
   - 초기화 관련 수정 시 한 파일만 확인
   - 디버깅 시간 단축

4. **코드 라인 감소**
   - `AppStartupLogic` 클래스 삭제 (약 40줄)
   - `MoodLogApp`의 불필요한 파라미터 제거

## 🔧 구체적인 변경 사항

### 1. `lib/presentation/widgets/app_initializer.dart`

**변경 전:**
```dart
Future<void> _initializeApp() async {
  await context.read<AppStateProvider>().loadSettings();

  if (mounted) {
    setState(() {
      _isInitialized = true;
    });
  }
}

@override
Widget build(BuildContext context) {
  if (!_isInitialized) {
    return Container(color: const Color(0xFFFFFFFF));
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });

  return MoodLogApp(
    analyticsObserver: widget.analyticsRepo.navigatorObserver,
    onAppStarted: (context) async {
      await DataSeedingService(context).run();
      if (widget.onAppStartedDev != null) {
        await widget.onAppStartedDev!(context);
      }
    },
  );
}
```

**변경 후:**
```dart
Future<void> _initializeApp() async {
  // 1. Settings 로드
  await context.read<AppStateProvider>().loadSettings();

  // 2. 데이터 시딩 실행
  if (mounted) {
    await DataSeedingService(context).run();
  }

  // 3. 개발용 콜백 실행 (테스트용)
  if (mounted && widget.onAppStartedDev != null) {
    await widget.onAppStartedDev!(context);
  }

  // 4. 초기화 완료
  if (mounted) {
    setState(() {
      _isInitialized = true;
    });
  }
}

@override
Widget build(BuildContext context) {
  if (!_isInitialized) {
    return Container(color: const Color(0xFFFFFFFF));
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });

  // 순수하게 앱만 반환
  return MoodLogApp(
    analyticsObserver: widget.analyticsRepo.navigatorObserver,
  );
}
```

### 2. `lib/app.dart`

**변경 내용:**

1. `MoodLogApp` 클래스에서 다음 제거:
   - `onAppStarted` 파라미터
   - `builder` 파라미터 (또는 단순화)

2. `AppStartupLogic` 클래스 전체 삭제 (89-119줄)

**변경 전:**
```dart
class MoodLogApp extends StatefulWidget {
  final NavigatorObserver? analyticsObserver;
  final Future<void> Function(BuildContext context)? onAppStarted;

  const MoodLogApp({this.analyticsObserver, this.onAppStarted, super.key});

  // ...

  @override
  Widget build(BuildContext context) {
    // ...
    return KeyboardDismissOnTapOutside(
      child: MaterialApp.router(
        // ...
        routerConfig: _router,
        builder: (context, child) {
          return AppStartupLogic(
            onAppStarted: widget.onAppStarted,
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class AppStartupLogic extends StatefulWidget {
  // ... 전체 클래스 (30줄)
}

class _AppStartupLogicState extends State<AppStartupLogic> {
  // ... 전체 클래스 (20줄)
}
```

**변경 후:**
```dart
class MoodLogApp extends StatefulWidget {
  final NavigatorObserver? analyticsObserver;

  const MoodLogApp({this.analyticsObserver, super.key});

  // ...

  @override
  Widget build(BuildContext context) {
    // ...
    return KeyboardDismissOnTapOutside(
      child: MaterialApp.router(
        // ...
        routerConfig: _router,
        // builder 제거 또는 단순화
      ),
    );
  }
}

// AppStartupLogic 클래스 삭제
```

### 3. `lib/main.dart`

변경 불필요 (이미 `AppInitializer`를 사용하고 있음)

## 📊 예상 효과

### 정량적 개선

| 항목 | Before | After | 개선 |
|------|--------|-------|------|
| 초기화 관련 컴포넌트 수 | 3개 | 2개 | 33% ↓ |
| 콜백 전달 단계 | 3단계 | 0단계 | 100% ↓ |
| 코드 라인 수 | ~190줄 | ~150줄 | 21% ↓ |
| 파일 수 | 3개 | 2개 | 33% ↓ |

### 정성적 개선

- ✅ 초기화 로직이 한 곳에 집중되어 이해하기 쉬움
- ✅ 콜백 체인 제거로 디버깅 용이
- ✅ 각 컴포넌트의 책임이 명확해짐
- ✅ Native splash screen 관리와 데이터 시딩이 함께 처리됨

## 🚀 실행 계획

### 단계별 작업

1. **Step 1**: `AppInitializer` 수정
   - `_initializeApp()`에 데이터 시딩 로직 추가
   - `build()` 메서드에서 `onAppStarted` 제거

2. **Step 2**: `MoodLogApp` 수정
   - `onAppStarted` 파라미터 제거
   - `builder` 파라미터 제거/단순화
   - `AppStartupLogic` 클래스 삭제

3. **Step 3**: 테스트
   - 앱 실행하여 초기화 동작 확인
   - Native splash screen 제거 타이밍 확인
   - 데이터 시딩이 정상 작동하는지 확인

4. **Step 4**: 코드 정리
   - 불필요한 import 제거
   - 주석 업데이트

### 예상 소요 시간

- 총 시간: 30분 ~ 1시간
- 난이도: ⭐ 낮음

## ⚠️ 주의사항

1. **`mounted` 체크 필수**
   - `DataSeedingService` 실행 전에 `mounted` 확인
   - 위젯이 dispose된 상태에서 비동기 작업 방지

2. **Native Splash Screen 타이밍**
   - 초기화 완료 후 splash 제거
   - 현재 동작과 동일하게 유지

3. **개발용 콜백 유지**
   - `onAppStartedDev` 파라미터는 테스트용으로 유지
   - 프로덕션에서는 사용되지 않음

## 📝 관련 파일

- `lib/presentation/widgets/app_initializer.dart` - 수정
- `lib/app.dart` - 수정
- `lib/main.dart` - 변경 없음

## 📚 참고

- 이 개선은 기능 변경이 아닌 구조 개선입니다
- 사용자 경험에는 영향이 없습니다
- Clean Architecture 원칙을 더 잘 따르게 됩니다

---

**상태**: 📝 계획 수립 완료
**다음 단계**: 구현 대기
