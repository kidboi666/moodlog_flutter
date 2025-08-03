# MoodLog Flutter Project - Claude Guidelines

## Project Structure

- Flutter 앱 with Provider state management
- Drift (SQLite) for local database
- AdMob integration for ads
- Firebase integration

## Development Conventions

### Internationalization

- `.arb` 파일에만 번역 텍스트 추가
- 자동 생성되는 `.dart` 파일은 수정하지 않음
- 지원 언어: ko, en, ja, zh, es, it, fr, vi, th (총 9개 언어)
- 새로운 언어 추가 시 순서:
    1. `lib/common/l10n/app_{language_code}.arb` 파일 생성
    2. `lib/common/constants/enum.dart`의 `LanguageCode` enum에 추가
    3. `lib/presentation/settings/widgets/dialog/language_dialog.dart`에 UI 추가
    4. `lib/main.dart`의 `supportedLocales`에 추가
    5. `l10n.yaml`의 `supported-locales`에 추가
    6. `flutter gen-l10n` 명령어로 자동 생성

### Commands

- Lint: `flutter analyze`
- Test: `flutter test`
- Build: `flutter build apk`

### Architecture

- MVVM + Clean Architecture
    - Common: `lib/common`
    - Data: `lib/data`
    - Domain: `lib/domain`
    - Presentation: `lib/presentation`

### File Patterns

- ViewModels: `lib/presentation/*/viewmodel/`
- Repositories: `lib/data/repositories/`
- Widgets: `lib/presentation/*/widgets/`
- Models: `lib/data/models/`

### Dependencies

- State Management: Provider
- Database: Drift
- Charts: fl_chart
- Ads: google_mobile_ads

### New Feature

- 위젯을 프라이빗 메서드로 구현하지 말고 새로운 파일로 된 위젯으로 분리할것

## Release Management

### Patch Notes

- 패치노트는 `docs/patch/{version}` 형식으로 저장
- 모든 지원 언어로 작성 (en-US, ko-KR, ja-JP, zh-CN, es-ES, it-IT, fr-FR, vi-VN, th-TH) 하고, 구글 플레이 콘솔에 새로운 버전 작성틀에 맞춰 한 파일안에 작성.
- 형식: 새로운 기능(🌍), 개선사항(🎨), 버그 수정(🔧)
- 길이: 각 지원 언어당 30자를 넘지 않음

### Supported Languages (v1.0.8+)

- Korean (한국어) - Default
- English
- Japanese (日本語)
- Chinese (中文)
- Spanish (Español)
- Italian (Italiano)
- French (Français)
- Vietnamese (Tiếng Việt)
- Thai (ไทย)