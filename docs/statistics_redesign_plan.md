# 통계 페이지 리디자인 구현 계획

## 개요

통계 페이지를 주간/월간/년간 탭으로 분리하고, 각 기간에 최적화된 새로운 위젯을 구현합니다.

## 기간 정의

- **주간 (Weekly)**: 최근 7일 (오늘 포함)
- **월간 (Monthly)**: 이번 달 (1일 ~ 말일)
- **년간 (Yearly)**: 올해 (1월 ~ 12월)

## 아키텍처

### 파일 구조

```
lib/presentation/screens/statistics/
├── statistics_view.dart              # 메인 뷰 (TabBar 포함)
├── statistics_content.dart           # 탭 컨텐츠 컨테이너
├── statistics_view_model.dart        # 확장된 뷰모델
└── widgets/
    ├── weekly/
    │   ├── weekly_summary_card.dart          # 주간 요약 카드
    │   ├── weekly_mood_line_chart.dart       # 7일 기분 추세 차트
    │   ├── weekly_activity_pattern.dart      # 요일별 활동 패턴
    │   └── weekly_emotion_keywords.dart      # TOP 5 감정 키워드
    ├── monthly/
    │   ├── monthly_calendar_heatmap.dart     # 월간 캘린더 히트맵
    │   ├── monthly_summary_card.dart         # 월간 요약 카드
    │   ├── monthly_weekly_comparison.dart    # 주차별 비교
    │   ├── monthly_top_activities.dart       # TOP 10 활동
    │   └── monthly_emotion_distribution.dart # 감정 분포 파이 차트
    └── yearly/
        ├── yearly_monthly_trend_chart.dart   # 12개월 추세 차트
        ├── yearly_dashboard_card.dart        # 년간 대시보드
        ├── yearly_quarter_comparison.dart    # 분기별 비교
        ├── yearly_growth_indicator.dart      # 성장 지표
        └── yearly_activity_report.dart       # 활동 리포트
```

## 주간 통계 위젯 상세

### 1. WeeklySummaryCard
- 3열 레이아웃 (총 체크인 / 평균 기분 / 최빈 기분)
- GradientBox 배경
- 각 항목에 아이콘 + 숫자/이모지 표시

### 2. WeeklyMoodLineChart
- 7일간 기분 점수 꺾은선 그래프
- X축: 요일 (월~일)
- Y축: 기분 점수 (1-5)
- 각 포인트에 기분 이모지 마커

### 3. WeeklyActivityPattern
- 요일별 체크인 횟수 막대 그래프
- 가장 활발한 요일 하이라이트

### 4. WeeklyEmotionKeywords
- TOP 5 감정 키워드
- Chip 형태로 표시
- 각 키워드 옆에 등장 횟수

## 월간 통계 위젯 상세

### 1. MonthlyCalendarHeatmap
- 달력 그리드 형태
- 각 날짜를 기분 색상으로 표시
- 체크인 없는 날은 회색

### 2. MonthlySummaryCard
- 4개 항목 2x2 그리드
  - 체크인 일수
  - 평균 기분
  - 현재 연속 기록
  - 지난 달 대비 변화

### 3. MonthlyWeeklyComparison
- 주차별(1주~5주) 평균 기분 비교
- 막대 그래프

### 4. MonthlyTopActivities
- TOP 10 활동 리스트
- 각 활동 옆에 횟수와 퍼센트 바

### 5. MonthlyEmotionDistribution
- 긍정/중립/부정 감정 비율
- 도넛 또는 파이 차트

## 년간 통계 위젯 상세

### 1. YearlyMonthlyTrendChart
- 12개월 기분 추세 꺾은선 그래프
- X축: 월 (1월~12월)
- Y축: 평균 기분 점수

### 2. YearlyDashboardCard
- 4개 항목 2x2 그리드
  - 총 체크인 수
  - 년간 평균 기분
  - 최고의 달
  - 최악의 달

### 3. YearlyQuarterComparison
- 분기별(Q1-Q4) 평균 기분 비교
- 막대 그래프

### 4. YearlyGrowthIndicator
- 상반기 vs 하반기 성장 곡선
- 면적 그래프

### 5. YearlyActivityReport
- TOP 20 활동
- 워드 클라우드 스타일 또는 트리맵

## ViewModel 확장

### 새로운 프로퍼티

```dart
// 기간별 필터링된 체크인
List<CheckIn> get weeklyCheckIns
List<CheckIn> get monthlyCheckIns
List<CheckIn> get yearlyCheckIns

// 주간 통계
double get weeklyAverageMood
MoodType? get weeklyMostFrequentMood
Map<int, int> get weeklyDayPattern // 요일(1-7) -> 횟수
List<String> get weeklyTopEmotions // TOP 5

// 월간 통계
int get monthlyCheckInDays
double get monthlyAverageMood
int get monthlyCurrentStreak
double get monthlyVsLastMonth
Map<int, List<CheckIn>> get monthlyWeeklyGroups
List<String> get monthlyTopActivities // TOP 10
Map<String, int> get monthlyEmotionDistribution // positive/neutral/negative

// 년간 통계
int get yearlyTotalCheckIns
double get yearlyAverageMood
String get yearlyBestMonth
String get yearlyWorstMonth
Map<int, double> get yearlyMonthlyAverages // 월(1-12) -> 평균 기분
Map<int, double> get yearlyQuarterAverages // 분기(1-4) -> 평균 기분
List<String> get yearlyTopActivities // TOP 20
```

## UI/UX 디자인

### TabBar 스타일
- Material Design 3
- 상단에 고정
- 3개 탭: 주간 / 월간 / 년간
- 선택된 탭 하이라이트

### 공통 스타일
- GradientBox 배경 사용
- BaseCard 컴포넌트 활용
- 현재 앱 디자인과 일관성 유지
- FadeIn 애니메이션 적용

### 차트 라이브러리
- fl_chart 패키지 활용
- 앱 테마 색상 적용

## 다국어 키

### 공통
- statistics_weekly
- statistics_monthly
- statistics_yearly

### 주간
- statistics_weekly_summary
- statistics_weekly_total_checkins
- statistics_weekly_avg_mood
- statistics_weekly_most_frequent_mood
- statistics_weekly_mood_trend
- statistics_weekly_activity_pattern
- statistics_weekly_top_emotions

### 월간
- statistics_monthly_calendar
- statistics_monthly_summary
- statistics_monthly_checkin_days
- statistics_monthly_avg_mood
- statistics_monthly_current_streak
- statistics_monthly_vs_last_month
- statistics_monthly_weekly_comparison
- statistics_monthly_top_activities
- statistics_monthly_emotion_distribution
- statistics_monthly_positive
- statistics_monthly_neutral
- statistics_monthly_negative

### 년간
- statistics_yearly_trend
- statistics_yearly_dashboard
- statistics_yearly_total_checkins
- statistics_yearly_avg_mood
- statistics_yearly_best_month
- statistics_yearly_worst_month
- statistics_yearly_quarter_comparison
- statistics_yearly_growth
- statistics_yearly_activity_report
- statistics_yearly_q1
- statistics_yearly_q2
- statistics_yearly_q3
- statistics_yearly_q4

## 구현 순서

1. StatisticsViewModel 확장 (기간별 필터링 메서드)
2. TabBar UI 구현 (statistics_view.dart)
3. 주간 통계 위젯 구현 (4개)
4. 월간 통계 위젯 구현 (5개)
5. 년간 통계 위젯 구현 (5개)
6. 탭 컨텐츠 레이아웃 구성
7. 다국어 키 추가
8. 테스트 및 최적화

## 구현 진행 상황

### ✅ 완료된 작업

#### 1. 기본 구조 및 아키텍처
- ✅ StatisticsViewModel 확장 (224줄 추가)
  - 기간별 필터링 메서드 (weeklyCheckInsList, monthlyCheckInsList, yearlyCheckInsList)
  - 주간 통계 계산 메서드 (평균 기분, 최빈 기분, 요일 패턴, TOP 감정)
  - 월간 통계 계산 메서드 (체크인 일수, 연속 기록, 지난 달 대비, 주차별 그룹, TOP 활동, 감정 분포)
  - 년간 통계 계산 메서드 (총 체크인, 월별/분기별 평균, 최고/최악의 달, TOP 활동)
- ✅ TabBar UI 구현
  - statistics_content.dart에 TabController 추가
  - 3개 탭 (주간/월간/년간) 구성
  - 각 탭별 CustomScrollView 레이아웃

#### 2. 주간 통계 위젯 (4/4 완료)
- ✅ WeeklySummaryCard (lib/presentation/screens/statistics/widgets/weekly/weekly_summary_card.dart)
  - 3열 레이아웃 (총 체크인 / 평균 기분 / 최빈 기분)
  - 구분선으로 영역 분리
- ✅ WeeklyMoodLineChart (lib/presentation/screens/statistics/widgets/weekly/weekly_mood_line_chart.dart)
  - CustomPainter로 꺾은선 그래프 구현
  - 각 데이터 포인트에 이모지 표시
  - 요일 레전드 포함
- ✅ WeeklyActivityPattern (lib/presentation/screens/statistics/widgets/weekly/weekly_activity_pattern.dart)
  - 요일별 체크인 횟수 막대 그래프
  - 최고 빈도 요일 하이라이트
- ✅ WeeklyEmotionKeywords (lib/presentation/screens/statistics/widgets/weekly/weekly_emotion_keywords.dart)
  - TOP 5 감정 키워드 순위 표시
  - 순위별 색상 구분

#### 3. 월간 통계 위젯 (5/5 완료)
- ✅ MonthlySummaryCard (lib/presentation/screens/statistics/widgets/monthly/monthly_summary_card.dart)
  - 2x2 그리드 레이아웃
  - 4개 항목: 체크인 일수 / 평균 기분 / 현재 연속 기록 / 지난 달 대비
  - 지난 달 대비 증감 색상 표시
- ✅ MonthlyCalendarHeatmap (lib/presentation/screens/statistics/widgets/monthly/monthly_calendar_heatmap.dart)
  - 월간 캘린더 그리드 (7x5 최대)
  - 체크인 빈도에 따른 색상 강도 표시
  - 요일 헤더 및 범례 포함
- ✅ MonthlyWeeklyComparison (lib/presentation/screens/statistics/widgets/monthly/monthly_weekly_comparison.dart)
  - 주차별 (1주~5주) 막대 그래프
  - 평균 기분에 따른 색상 변화 (초록/파랑/주황/빨강)
  - 체크인 수 및 평균 기분 표시
- ✅ MonthlyTopActivities (lib/presentation/screens/statistics/widgets/monthly/monthly_top_activities.dart)
  - TOP 10 활동 목록
  - LinearProgressIndicator로 비율 시각화
  - 횟수 및 백분율 표시
- ✅ MonthlyEmotionDistribution (lib/presentation/screens/statistics/widgets/monthly/monthly_emotion_distribution.dart)
  - TOP 8 감정 키워드 목록
  - 색상 막대 및 진행 바로 시각화
  - 횟수 및 백분율 표시

#### 4. 다국어 지원
- ✅ 한국어 (app_ko.arb): 40개 키 추가
- ✅ 영어 (app_en.arb): 40개 키 추가
- ✅ 일본어 (app_ja.arb): 40개 키 추가
- 추가된 주요 키:
  - 공통: common_less, common_more, common_unit_day
  - 주간: statistics_weekly_*, calendar_weekday_*
  - 월간: statistics_monthly_*, statistics_emotion_keywords_empty
  - 년간: statistics_yearly_*, ai_report_*

#### 5. 통합 및 빌드
- ✅ 주간 위젯 통합 (statistics_content.dart - _WeeklyStatisticsTab)
- ✅ 월간 위젯 통합 (statistics_content.dart - _MonthlyStatisticsTab)
- ✅ 빌드 테스트 완료 (app-development-debug.apk)

### ⏳ 대기 중인 작업

#### 6. 년간 통계 위젯 (0/5)
- ⏳ YearlyMonthlyTrendChart - 12개월 추세 꺾은선 그래프
- ⏳ YearlyDashboardCard - 년간 대시보드 카드
- ⏳ YearlyQuarterComparison - 분기별 비교 막대 그래프
- ⏳ YearlyGrowthIndicator - 상반기 vs 하반기 성장 지표
- ⏳ YearlyActivityReport - TOP 20 활동 리포트

#### 7. 성능 최적화 및 마무리
- ⏳ 년간 위젯 통합
- ⏳ 성능 최적화
- ⏳ 최종 테스트

## 테스트 체크리스트

### 주간 탭
- ✅ 7일 데이터 정확성 확인
- ✅ 빈 상태 처리 (no data)
- ✅ 다국어 문자열 표시
- [ ] 다크 모드 지원 확인
- [ ] 대량 데이터 성능 테스트

### 월간 탭
- ✅ 현재 월 데이터 정확성 확인
- ✅ 빈 상태 처리
- ✅ 다국어 문자열 표시
- [ ] 다크 모드 지원 확인
- [ ] 대량 데이터 성능 테스트

### 년간 탭
- [ ] 올해 데이터 정확성 확인
- [ ] 빈 상태 처리
- [ ] 다국어 문자열 표시
- [ ] 다크 모드 지원 확인
- [ ] 대량 데이터 성능 테스트

### 공통
- ✅ 탭 전환 애니메이션
- ✅ Glower 효과 적용
- [ ] 스크롤 성능
- [ ] 메모리 사용량
