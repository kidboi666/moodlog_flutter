# MoodLog Flutter Project - Gemini Guidelines

## Project Overview

MoodLog is a mood tracking and journaling Flutter app with the following key features:
- Local-first architecture (no login required)
- Mood tracking with AI-powered insights
- Private diary entries stored locally
- Statistics and analytics

## Project Structure

- **State Management**: Provider
- **Routing**: go_router
- **Database**: Drift (SQLite) for local storage
- **AI Integration**: Firebase AI (Gemini)
- **Analytics**: Firebase Analytics
- **Ads**: Google Mobile Ads

## Architecture

### MVVM + Clean Architecture

```
lib/
├── core/           # Common utilities, constants, themes
├── data/           # Repositories, data sources, models
├── domain/         # Entities, repository interfaces, use cases
└── presentation/   # UI, ViewModels, widgets
```

### File Patterns

- **ViewModels**: `lib/presentation/*/viewmodel/` or `lib/presentation/*/*_view_model.dart`
- **Repositories**: `lib/data/repositories/*_repository_impl.dart`
- **Widgets**: `lib/presentation/*/widgets/`
- **Models**: `lib/data/models/`
- **Entities**: `lib/domain/entities/`

## Key Architectural Decisions (v1.0.28+)

### Local-First Architecture

**No Authentication Required**:
- Firebase Auth has been removed
- Users are created locally on first app launch
- All data is stored locally (Drift + SharedPreferences)

**User Management**:
- `LocalUser` entity with: userId (UUID), nickname, profileImagePath, createdAt
- Stored in SharedPreferences
- No email or external account linking

**Onboarding Flow**:
1. First launch → Show onboarding screens
2. User sets nickname and AI personality
3. Local user automatically created
4. App ready to use

**Data Storage**:
- Journal entries: Drift (SQLite)
- User info & settings: SharedPreferences
- No cloud sync (future feature)

## Development Conventions

### Internationalization

- **Supported Languages**: Korean (default), English, Japanese
- **Translation Files**: `lib/core/l10n/app_{language_code}.arb`
- Only edit `.arb` files; `.dart` files are auto-generated
- Base language is Korean (ko)

### Code Generation

```bash
# Generate localization files
flutter gen-l10n

# Generate freezed/json_serializable code
dart run build_runner build --delete-conflicting-outputs
```

### Common Commands

```bash
flutter analyze          # Lint check
flutter test            # Run tests
flutter build apk       # Build Android APK
```

### Code Style

- Use `withValues(alpha: ..)` instead of deprecated `withOpacity`
- Follow MVVM pattern: View → ViewModel → UseCase → Repository
- Use freezed for immutable entities and models
- Use Provider for state management

## Key Components

### User Management
- `LocalUser`: User entity (domain/entities/user/)
- `LocalUserRepository`: User data management (domain/repositories/)
- `LocalUserRepositoryImpl`: SharedPreferences implementation (data/repositories/)
- `UserProvider`: User state management (presentation/providers/)

### Settings Management
- `Settings`: App settings entity
- `AppStateProvider`: Settings state management
- Stored in SharedPreferences

### Journal Management
- `Journal`: Journal entry entity
- `JournalRepository`: Journal CRUD operations
- `JournalLocalDataSource`: Drift database operations
- Stored in SQLite

### AI Integration
- Firebase AI (Gemini) for mood analysis
- `GeminiRepository`: AI operations
- `GeminiUseCase`: Business logic for AI features

## Important Notes for AI Assistants

1. **Do NOT reintroduce Firebase Auth** - The app is now local-first by design
2. **Do NOT add login/signup screens** - Use onboarding only
3. **LocalUser is NOT Firebase User** - Different entity with different fields
4. **No email field** - LocalUser only has userId, nickname, profileImagePath, createdAt
5. **All data is local** - No cloud sync currently implemented

## Release Management

### Patch Notes

- Location: `docs/patch/{version}`
- Languages: ko-KR, en-US, ja-JP
- Format: Use emoji categories (🌍 new feature, 🎨 improvement, 🔧 bug fix)
- Length: Max 30 characters per language

### Version Bump

Always ask before bumping version in `pubspec.yaml`

## Reference Documents

- Architecture Plan: `docs/local_first_architecture_plan.md`
- Refactoring Plan: `docs/REFACTORING_PLAN.md`
- Code Analysis: `docs/code_analysis_report.md`

## Supported Languages

- Korean (한국어) - Default
- English
- Japanese (日本語)
