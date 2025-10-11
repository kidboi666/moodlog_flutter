# 로컬 우선 아키텍처 전환 계획

> **작업 진행 상태**: Phase 1-3 완료 (2025-01-11)
> **다음 작업**: LocalUser freezed 파일 생성 및 ViewModel 수정

## 개요

현재 Firebase Authentication에 의존하는 로그인 시스템을 제거하고, 로컬 우선 아키텍처로 전환합니다.
사용자는 별도의 로그인 과정 없이 앱을 설치하고 온보딩만 완료하면 바로 사용할 수 있습니다.

## 현재 아키텍처 분석

### 인증 시스템
- **Firebase Auth 사용**: 익명/Google/Apple 로그인 지원
- **UserProvider**: Firebase Auth의 user stream을 구독하여 인증 상태 관리
- **라우터 로직**: `router.dart:161-213`에서 인증 상태 체크 후 로그인 화면으로 리다이렉트

### 데이터 저장
- **Drift (SQLite)**: 일기 데이터를 로컬에 저장 (이미 로컬 우선)
- **SharedPreferences**: 앱 설정 저장
- **Firebase 사용처**: 인증, AI (Gemini), Analytics만 사용

### 로그인 관련 UI
- `lib/presentation/auth/` - 로그인 화면 및 ViewModel
- `lib/presentation/profile/` - 로그인 상태 표시, 로그아웃/계정삭제
- `lib/presentation/onboarding/` - 온보딩 화면 (LoginMethod 파라미터 받음)

---

## 전환 계획

### 1단계: 로컬 사용자 관리 시스템 구축

#### 1.1 LocalUserRepository 생성
```dart
// lib/domain/repositories/local_user_repository.dart
abstract class LocalUserRepository {
  Future<LocalUser?> getUser();
  Future<LocalUser> createUser({required String nickname});
  Future<void> updateUser(LocalUser user);
  Future<void> deleteAllData();
}
```

#### 1.2 구현체 생성
```dart
// lib/data/repositories/local_user_repository_impl.dart
class LocalUserRepositoryImpl implements LocalUserRepository {
  final SharedPreferencesLocalDataSource _prefs;

  // UUID 기반 로컬 사용자 ID 생성
  // SharedPreferences에 사용자 정보 저장
  // - userId (UUID)
  // - nickname
  // - profileImagePath
  // - createdAt
}
```

#### 1.3 LocalUser 엔티티 생성
```dart
// lib/domain/entities/user/local_user.dart
@freezed
class LocalUser with _$LocalUser {
  const factory LocalUser({
    required String userId,
    required String nickname,
    String? profileImagePath,
    required DateTime createdAt,
  }) = _LocalUser;
}
```

### 2단계: UserProvider 로컬 전환

#### 2.1 UserProvider 수정
```dart
// lib/presentation/providers/user_provider.dart
class UserProvider extends ChangeNotifier with AsyncStateMixin {
  final LocalUserRepository _localUserRepository;

  LocalUser? _user;
  LocalUser? get user => _user;

  // Firebase Auth Stream 제거
  // isAuthenticated를 로컬 사용자 존재 여부로 체크
  bool get isAuthenticated => _user != null;

  Future<void> initialize() async {
    _user = await _localUserRepository.getUser();
    notifyListeners();
  }
}
```

#### 2.2 DI 컨테이너 수정
```dart
// lib/core/di/injection_container.dart
// AuthRepository, AuthUseCase 제거
// LocalUserRepository 추가
```

### 3단계: 라우터 로직 단순화

#### 3.1 router.dart 수정
```dart
Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final AppStateProvider appStateProvider = context.read<AppStateProvider>();
  final bool isOnboardingComplete = appStateProvider.appState.isOnboardingComplete;
  final String location = state.matchedLocation;
  final bool isOnboarding = location == Routes.onboarding;

  // 온보딩 미완료 시 온보딩 화면으로
  if (!isOnboardingComplete && !isOnboarding) {
    return Routes.onboarding;
  }

  // 온보딩 완료 시 온보딩 화면 접근 차단
  if (isOnboardingComplete && isOnboarding) {
    return Routes.home;
  }

  return null;
}
```

#### 3.2 Routes 정리
```dart
// lib/core/routing/routes.dart
// Routes.signIn 제거
```

#### 3.3 라우트 정의 수정
```dart
// lib/core/routing/router.dart
GoRouter router(
  AppStateProvider appStateProvider,
  NavigatorObserver? analyticsObserver,
) => GoRouter(
  // UserProvider 파라미터 제거
  refreshListenable: appStateProvider,
  // ...
);
```

### 4단계: 온보딩 간소화

#### 4.1 OnboardingViewModel 수정
```dart
// lib/presentation/onboarding/onboarding_view_model.dart
class OnboardingViewModel extends ChangeNotifier {
  final AppStateProvider _appStateProvider;
  final LocalUserRepository _localUserRepository;

  // LoginMethod 파라미터 제거
  // signInAnonymously 로직 제거

  Future<void> completeOnboarding() async {
    // 로컬 사용자 생성
    await _localUserRepository.createUser(nickname: _nickname);

    // 온보딩 완료 플래그 저장
    final updatedSettings = appState.copyWith(
      isOnboardingComplete: true,
      aiPersonality: selectedPersonality,
    );
    await _appStateProvider.update(updatedSettings);
  }
}
```

#### 4.2 OnboardingView 수정
```dart
// lib/presentation/onboarding/onboarding_view.dart
class OnboardingScreen extends StatelessWidget {
  // LoginMethod loginType 파라미터 제거

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(
        appStateProvider: context.read(),
        localUserRepository: context.read(),
        totalSteps: 2, // 닉네임, AI 성격 설정만
      ),
      child: _OnboardingScreenContent(),
    );
  }
}
```

### 5단계: UI 정리

#### 5.1 삭제할 파일들
```
lib/presentation/auth/
  ├── auth_view.dart
  ├── auth_content.dart
  ├── auth_view_model.dart
  └── widgets/
      ├── apple_signin_button.dart
      ├── google_signin_button.dart
      ├── guest_signin_button.dart
      └── sign_in_terms_message.dart

lib/presentation/profile/widgets/
  ├── guest_login_button.dart
  ├── sign_out_button.dart
  └── dialog/
      ├── sign_out_dialog.dart
      └── delete_account_form_dialog.dart

lib/data/repositories/auth_repository_impl.dart
lib/domain/repositories/auth_repository.dart
lib/domain/use_cases/auth_use_case.dart
lib/data/extensions/firebase_extension.dart
```

#### 5.2 Profile 화면 수정
```dart
// lib/presentation/profile/profile_content.dart
// 로그인/로그아웃 관련 위젯 제거
// AccountCard, GuestLoginButton, SignOutButton, DeleteAccountButton 제거
// 닉네임, 프로필 이미지만 표시
```

#### 5.3 Settings 엔티티 수정
```dart
// lib/domain/entities/app/settings.dart
@freezed
abstract class Settings with _$Settings {
  const factory Settings({
    // isSocialOnboardingComplete 필드 제거
    @Default(false) bool isOnboardingComplete,
    // shouldShowOnboarding 메서드 단순화
  }) = _Settings;

  bool shouldShowOnboarding() => !isOnboardingComplete;
}
```

### 6단계: 의존성 정리

#### 6.1 pubspec.yaml 수정
```yaml
# 제거할 의존성
dependencies:
  # firebase_auth: ^6.1.0  # 제거
  # google_sign_in: ^7.2.0  # 제거
  # sign_in_with_apple: ^7.0.1  # 제거
  # crypto: ^3.0.6  # Apple 로그인용, 제거
  # dart_jsonwebtoken: ^3.2.0  # Apple 로그인용, 제거

# 유지할 Firebase 의존성 (AI 기능용)
dependencies:
  firebase_core: ^4.1.1  # 유지
  firebase_ai: ^3.3.0  # 유지
  firebase_analytics: ^12.0.2  # 유지
```

#### 6.2 main.dart 수정
```dart
// lib/main.dart
// Firebase Auth 초기화 로직은 유지 (Firebase AI를 위해)
// AuthRepository 관련 Provider 제거
```

### 7단계: 다국어 및 코드 생성

#### 7.1 다국어 키 정리
```
lib/core/l10n/app_*.arb
- 로그인 관련 키 제거:
  - signin_*
  - signout_*
  - auth_*
  - guest_*
  - delete_account_*
  - account_*
```

#### 7.2 코드 생성
```bash
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
```

### 8단계: 테스트 및 검증

#### 8.1 테스트 시나리오
1. **첫 설치**
   - 앱 실행 → 온보딩 화면 표시
   - 닉네임, AI 성격 설정 → 홈 화면 진입
   - 로컬 사용자 ID 생성 확인

2. **재실행**
   - 앱 종료 후 재실행 → 바로 홈 화면 진입
   - 사용자 정보 유지 확인

3. **데이터 삭제**
   - 설정에서 모든 데이터 삭제
   - 온보딩 화면으로 이동 확인

#### 8.2 마이그레이션 처리
기존 사용자를 위한 마이그레이션 로직:
```dart
// lib/data/repositories/local_user_repository_impl.dart
Future<void> migrateFromFirebaseAuth() async {
  // SharedPreferences에 기존 사용자 정보가 없고
  // Settings에 isOnboardingComplete == true인 경우
  // → 로컬 사용자 자동 생성 (닉네임: "사용자", UUID 생성)
}
```

---

## 예상 효과

### 긍정적 효과
1. **사용자 경험 개선**
   - 로그인 과정 제거로 진입 장벽 낮아짐
   - 온보딩 시간 단축 (로그인 → 온보딩 vs 온보딩만)

2. **개인정보 보호**
   - 외부 서버에 사용자 정보 전송 불필요
   - 완전한 로컬 저장으로 프라이버시 강화

3. **코드 단순화**
   - Firebase Auth 관련 복잡한 로직 제거
   - 라우팅 로직 단순화
   - 의존성 감소

4. **비용 절감**
   - Firebase Auth 사용료 감소 (무료 티어 범위 내)
   - Google/Apple 로그인 API 사용 불필요

### 고려사항
1. **기기 변경 시 데이터 이동 불가**
   - 로컬 저장만 하므로 기기 간 동기화 불가
   - → 추후 백업/복원 기능 추가 필요

2. **다중 기기 지원 불가**
   - 현재 아키텍처로는 하나의 기기에서만 사용 가능
   - → 추후 클라우드 동기화 기능 추가 시 계정 시스템 재도입 필요

3. **기존 사용자 마이그레이션**
   - Firebase Auth 사용 중인 기존 사용자 처리 필요
   - → 자동 마이그레이션 로직 구현 필요

---

## 작업 순서

### Phase 1: 기반 구축 (리스크 낮음)
1. LocalUser 엔티티 생성
2. LocalUserRepository 인터페이스 및 구현체 생성
3. DI 컨테이너에 등록

### Phase 2: Provider 전환 (리스크 중간)
4. UserProvider 로컬 버전으로 수정
5. 기존 Firebase 버전과 병행 테스트

### Phase 3: 라우팅 수정 (리스크 중간)
6. 라우터 로직 단순화
7. OnboardingViewModel 수정
8. Settings 엔티티 수정

### Phase 4: UI 정리 (리스크 낮음)
9. Auth 관련 UI 제거
10. Profile 화면 수정
11. 다국어 키 정리

### Phase 5: 의존성 정리 (리스크 낮음)
12. pubspec.yaml 수정
13. 미사용 코드 제거
14. 코드 생성 (`flutter gen-l10n`)

### Phase 6: 테스트 및 배포 (리스크 높음)
15. 첫 설치 시나리오 테스트
16. 기존 사용자 마이그레이션 테스트
17. 회귀 테스트
18. 베타 배포 및 피드백 수집

---

## 롤백 계획

만약 문제 발생 시 빠르게 롤백할 수 있도록:
1. Git 브랜치 생성: `feature/local-first-architecture`
2. 각 Phase마다 커밋 생성
3. 문제 발생 시 이전 커밋으로 revert

---

## 참고 자료

- 현재 라우팅 로직: `lib/core/routing/router.dart:161-213`
- 현재 인증 로직: `lib/data/repositories/auth_repository_impl.dart`
- 현재 온보딩 로직: `lib/presentation/onboarding/onboarding_view_model.dart`
- Settings 엔티티: `lib/domain/entities/app/settings.dart`
- Database: `lib/data/data_source/local/database/database.dart`

---

## 작업 진행 기록

### 2025-01-11: Phase 1-3 완료

#### ✅ 완료된 작업

**Phase 1: 로컬 사용자 관리 시스템 구축**
- [x] `LocalUser` 엔티티 생성 (`lib/domain/entities/user/local_user.dart`)
- [x] `LocalUserRepository` 인터페이스 생성 (`lib/domain/repositories/local_user_repository.dart`)
- [x] `LocalUserRepositoryImpl` 구현체 생성 (`lib/data/repositories/local_user_repository_impl.dart`)
  - UUID 기반 사용자 ID 생성 (timestamp + random)
  - SharedPreferences에 사용자 정보 저장
- [x] PreferenceKeys 추가 (`lib/core/constants/common.dart`)
  - `localUserId`, `localUserNickname`, `localUserProfileImage`, `localUserCreatedAt`
- [x] DI 컨테이너에 LocalUserRepository 등록 (`lib/core/di/injection_container.dart`)

**Phase 2: UserProvider 로컬 전환**
- [x] `UserProvider` 수정 (`lib/presentation/providers/user_provider.dart`)
  - Firebase Auth Stream 제거
  - LocalUserRepository 기반으로 변경
  - `initialize()` 및 `refresh()` 메서드 추가
  - `isAuthenticated`를 로컬 사용자 존재 여부로 체크
- [x] DI 컨테이너의 UserProvider 생성자 수정

**Phase 3: 라우팅 및 온보딩 로직 단순화**
- [x] Settings 엔티티 수정 (`lib/domain/entities/app/settings.dart`)
  - `isSocialOnboardingComplete` 필드 제거
  - `shouldShowOnboarding()` 메서드 단순화
- [x] AppStateSharedPreferencesModel 수정 (`lib/data/models/app_state_shared_preferences_model.dart`)
  - `isSocialOnboardingComplete` 필드 제거
- [x] 라우터 로직 단순화 (`lib/core/routing/router.dart`)
  - UserProvider 파라미터 제거
  - `_redirect` 함수 단순화 (인증 체크 제거, 온보딩만 확인)
  - Routes.signIn 제거
- [x] app.dart의 router 호출 부분 수정
- [x] OnboardingViewModel 수정 (`lib/presentation/onboarding/onboarding_view_model.dart`)
  - LoginMethod 파라미터 제거
  - LocalUserRepository 및 UserProvider 주입
  - `completeOnboarding()` 메서드로 변경 (로컬 사용자 생성)
  - Firebase Auth 로직 제거
- [x] OnboardingView 수정 (`lib/presentation/onboarding/onboarding_view.dart`)
  - LoginMethod 파라미터 제거
  - 뒤로가기 로직 단순화
- [x] onboarding_pageview_success.dart 수정
  - `setOnboardingCompleted()` → `completeOnboarding()` 변경
- [x] Unused imports 제거
  - router.dart: auth_view.dart, user_provider.dart 제거
  - onboarding_view.dart: go_router, enum, routes 제거

**코드 생성 및 빌드**
- [x] `dart run build_runner build --delete-conflicting-outputs` 실행 성공

#### ⚠️ 발견된 에러 (27개)

**1. LocalUser freezed 파일 누락**
```
error • Missing concrete implementations of 'getter mixin _$LocalUser...'
```
→ `lib/domain/entities/user/local_user.dart`에 `part 'local_user.freezed.dart';` 추가 필요

**2. ViewModel들의 LocalUser 타입 불일치**
- `lib/presentation/base_layout/base_layout_view_model.dart` - photoURL, displayName, email 접근
- `lib/presentation/home/home_view_model.dart` - photoURL, displayName, email 접근
- `lib/presentation/profile/profile_view_model.dart` - isCurrentGoogleUser, isCurrentAppleUser, isAnonymousUser, currentSignInMethod 접근, User? 반환 타입
- `lib/presentation/settings/settings_view_model.dart` - photoURL 접근, User? 반환 타입
- `lib/presentation/statistics/statistics_view_model.dart` - photoURL 접근

**3. AuthViewModel 에러**
```
error • Too many positional arguments: 0 expected, but 1 found
```
→ `lib/presentation/auth/auth_view_model.dart:35` (Phase 4에서 제거 예정)

#### 📋 다음 단계 작업 리스트

**우선순위 1: 에러 수정**
1. LocalUser에 freezed part 추가 및 코드 재생성
2. LocalUser 필드 매핑
   - `user.profileImagePath` → photoURL 대체
   - `user.nickname` → displayName 대체
   - email 필드는 제거 (로컬 사용자는 이메일 없음)
3. 각 ViewModel 수정:
   - `base_layout_view_model.dart`
   - `home_view_model.dart`
   - `profile_view_model.dart`
   - `settings_view_model.dart`
   - `statistics_view_model.dart`

**우선순위 2: Phase 4 작업**
- Auth 관련 UI 제거 (auth 디렉토리 전체)
- Profile 화면에서 로그인/로그아웃 UI 제거
- 다국어 키 정리 (signin_, signout_, auth_ 등)

**우선순위 3: Phase 5 작업**
- pubspec.yaml 의존성 정리 (firebase_auth, google_sign_in, sign_in_with_apple 등)
- 미사용 코드 제거
- 최종 코드 생성 (`flutter gen-l10n`)

#### 🔧 수정이 필요한 파일 목록

```
lib/domain/entities/user/local_user.dart - part 추가
lib/presentation/base_layout/base_layout_view_model.dart
lib/presentation/home/home_view_model.dart
lib/presentation/profile/profile_view_model.dart
lib/presentation/settings/settings_view_model.dart
lib/presentation/statistics/statistics_view_model.dart
```

#### 📝 LocalUser 필드 매핑 가이드

```dart
// Before (Firebase User)
user.photoURL → user.email → user.displayName

// After (LocalUser)
user.profileImagePath  // 프로필 이미지 (nullable)
user.nickname          // 닉네임 (required)
user.userId            // 로컬 사용자 ID (required)
user.createdAt         // 생성 시간 (required)
// email 필드 없음
```