# Firebase Analytics Integration

## Overview
Firebase Analytics가 MoodLog 앱에 통합되어 사용자 행동과 앱 사용 패턴을 분석할 수 있습니다.

## Implementation Details

### Dependencies
- `firebase_analytics: ^12.0.0`
- `firebase_core: ^4.0.0` (기존)

### Architecture

#### Analytics Repository
- **Location**: `lib/data/repositories/analytics_repository_impl.dart`
- **Pattern**: Repository Pattern with Clean Architecture
- **Singleton**: Single instance across the app

#### Key Components
1. **AnalyticsRepositoryImpl** - Main analytics service
2. **GoRouter Observer** - Automatic screen tracking
3. **Event Tracking** - Custom events throughout the app

### Features

#### 1. Automatic Screen Tracking
```dart
GoRouter router(UserProvider userProvider) => GoRouter(
  observers: [AnalyticsRepositoryImpl().observer],
  // ...
);
```

#### 2. User Authentication Events
**Login Events**:
- Anonymous login tracking
- Google login tracking
- User ID assignment
- Login method property setting

**Location**: `lib/presentation/auth/viewmodel/auth_viewmodel.dart`

#### 3. Mood Entry Tracking
**Events Tracked**:
- Mood type (happy, sad, etc.)
- Entry type (manual)
- Image attachment presence
- Tag usage

**Location**: `lib/presentation/write/viewmodel/write_viewmodel.dart`

#### 4. Statistics View Tracking
**Events Tracked**:
- Statistics page views
- Time period selections
- Chart interactions

**Location**: `lib/presentation/statistics/viewmodel/statistics_viewmodel.dart`

#### 5. Settings Change Tracking
**Events Tracked**:
- Language changes
- Theme mode changes
- Color theme changes

**Location**: `lib/presentation/settings/viewmodel/settings_viewmodel.dart`

### Analytics Events

#### Custom Events
| Event Name | Parameters | Description |
|------------|------------|-------------|
| `mood_entry_created` | mood_type, entry_type, has_image, has_tag | User creates a mood entry |
| `mood_view` | view_type, period | User views mood statistics |
| `settings_changed` | setting_type, value | User changes app settings |
| `feature_used` | feature_name, context | User uses specific features |
| `user_engagement` | engagement_type, duration | User engagement metrics |

#### User Properties
- `login_method`: anonymous, google
- Custom properties for user segmentation

#### Screen Tracking
- Automatic page view tracking via GoRouter
- Screen names and navigation patterns
- User flow analysis

### Implementation Pattern

#### Event Logging
```dart
// Basic event
AnalyticsRepositoryImpl().logEvent(
  name: 'custom_event',
  parameters: {'key': 'value'},
);

// Mood entry
AnalyticsRepositoryImpl().logMoodEntry(
  moodType: 'happy',
  entryType: 'manual',
  hasImage: true,
  hasTag: false,
);
```

#### User Properties
```dart
// Set user ID
AnalyticsRepositoryImpl().setUserId(userId);

// Set user properties
AnalyticsRepositoryImpl().setUserProperty(
  name: 'login_method',
  value: 'google',
);
```

### Initialization

Analytics is initialized in `main.dart`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AnalyticsRepositoryImpl().initialize();
  // ...
}
```

### Data Privacy

#### Analytics Collection
- Analytics collection is enabled by default
- Complies with Firebase's data collection policies
- User consent can be managed through Firebase settings

#### Data Types Collected
- App usage patterns
- Feature usage statistics
- User navigation flows
- Performance metrics
- Crash reports (if enabled)

### Monitoring & Insights

#### Firebase Console Access
- Real-time user activity
- Event tracking and funnels
- User engagement metrics
- Retention analysis
- Custom dashboard creation

#### Key Metrics Tracked
- Daily/Monthly Active Users (DAU/MAU)
- Mood entry frequency
- Feature adoption rates
- User retention rates
- App session duration

### Benefits

1. **User Behavior Understanding**
   - How users interact with mood tracking
   - Most used features identification
   - User journey optimization

2. **Product Improvement**
   - Data-driven feature decisions
   - Performance bottleneck identification
   - User experience optimization

3. **Business Intelligence**
   - User engagement trends
   - Feature success metrics
   - Retention analysis

### Future Enhancements

1. **Advanced Events**
   - Mood pattern analysis
   - Weather correlation tracking
   - AI response usage metrics

2. **Custom Dashboards**
   - Mental health insights
   - Usage pattern visualizations
   - Personalized recommendations

3. **A/B Testing Integration**
   - Feature flag management
   - Experiment tracking
   - Performance comparison

## Files Modified/Created

### New Files
- `lib/data/repositories/analytics_repository_impl.dart`
- `docs/features/firebase_analytics.md`

### Modified Files
- `pubspec.yaml` - Added firebase_analytics dependency
- `lib/main.dart` - Added analytics initialization
- `lib/core/routing/router.dart` - Added analytics observer
- `lib/presentation/auth/viewmodel/auth_viewmodel.dart` - Added login tracking
- `lib/presentation/write/viewmodel/write_viewmodel.dart` - Added mood entry tracking
- `lib/presentation/statistics/viewmodel/statistics_viewmodel.dart` - Added view tracking
- `lib/presentation/settings/viewmodel/settings_viewmodel.dart` - Added settings tracking

## Testing

Run the following commands to ensure the implementation works correctly:

```bash
# Install dependencies
flutter packages get

# Check for any analysis issues
flutter analyze

# Build and test
flutter build apk
```

## Troubleshooting

### Common Issues
1. **Analytics not showing data**: Ensure Firebase project is properly configured
2. **Build errors**: Verify all dependencies are correctly installed
3. **Events not logging**: Check internet connectivity and Firebase configuration

### Debug Mode
Analytics events may be delayed in debug mode. Use Firebase DebugView for real-time testing.