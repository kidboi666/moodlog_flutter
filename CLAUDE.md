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

### Commands
- Lint: `flutter analyze`
- Test: `flutter test`
- Build: `flutter build apk`

### File Patterns
- ViewModels: `lib/presentation/*/viewmodel/`
- Widgets: `lib/presentation/*/widgets/`
- Services: `lib/data/services/`
- Models: `lib/data/models/`

### Dependencies
- State Management: Provider
- Database: Drift
- Charts: fl_chart
- Ads: google_mobile_ads