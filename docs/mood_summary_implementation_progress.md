# 감정 결산 기능 구현 진행 상황

## 📋 프로젝트 개요
체크인 데이터를 기반으로 일간/주간/월간 감정 결산을 자동 생성하는 기능 구현

## ✅ 완료된 작업

### 1단계: Domain Layer (완료)

#### 1.1 Constants & Enums
- **파일**: `lib/core/constants/enum.dart`
- **추가 사항**:
  ```dart
  enum MoodSummaryPeriod {
    daily,
    weekly,
    monthly;
  }
  ```
- **기능**: 일간/주간/월간 결산 주기 구분

#### 1.2 Entity
- **파일**: `lib/domain/entities/mood_summary/mood_summary.dart`
- **설명**: Freezed를 사용한 불변 Entity
- **주요 필드**:
  - `id`: 고유 식별자
  - `period`: 결산 주기 (일/주/월)
  - `startDate`, `endDate`: 결산 기간
  - `generatedAt`: 생성 시각
  - `emotionalFlow`: 감정 흐름 분석
  - `dominantMoods`: 주요 감정
  - `activityPatterns`: 활동 패턴 분석
  - `personalAdvice`: 개인화된 조언
  - `keyPoints`: 주목할 포인트
  - `metadata`: 추가 메타데이터

#### 1.3 Repository Interfaces
- **파일 1**: `lib/domain/repositories/mood_summary_repository.dart`
  - `getLatestSummary()`: 최신 결산 조회
  - `getSummariesByPeriod()`: 주기별 결산 목록 조회
  - `saveSummary()`: 결산 저장
  - `deleteSummary()`: 결산 삭제
  - `getSummaryByDateRange()`: 기간별 결산 조회
  - `getAllSummaries()`: 전체 결산 조회

- **파일 2**: `lib/domain/repositories/gemini_repository.dart`
  - `generateMoodSummary()`: 체크인 데이터 기반 결산 생성

#### 1.4 Use Case
- **파일**: `lib/domain/use_cases/mood_summary_use_case.dart`
- **주요 기능**:
  - `generateDailySummary()`: 일간 결산 생성
  - `generateWeeklySummary()`: 주간 결산 생성
  - `generateMonthlySummary()`: 월간 결산 생성
  - `getLatestSummary()`: 최신 결산 조회
  - `shouldGenerateSummary()`: 생성 필요 여부 판단
  - `checkAndAutoGenerate()`: 앱 시작 시 자동 생성 체크

### 2단계: Data Layer (완료)

#### 2.1 Converter
- **파일**: `lib/core/utils/converter.dart`
- **추가 사항**:
  ```dart
  class JsonMapConverter extends TypeConverter<Map<String, dynamic>, String>
  ```
- **기능**: JSON 객체를 문자열로 변환하여 DB 저장

#### 2.2 Database Schema
- **파일**: `lib/data/data_source/local/database/schema.dart`
- **추가 테이블**: `MoodSummaries`
- **컬럼**:
  - `id`: 기본키
  - `period`: 결산 주기 (enum)
  - `startDate`, `endDate`: 결산 기간
  - `generatedAt`: 생성 시각
  - `emotionalFlow`: 감정 흐름 (TEXT)
  - `dominantMoods`: 주요 감정 (TEXT)
  - `activityPatterns`: 활동 패턴 (TEXT)
  - `personalAdvice`: 개인화된 조언 (TEXT)
  - `keyPoints`: 주목할 포인트 (TEXT)
  - `metadata`: 메타데이터 (JSON)
- **인덱스**:
  - `period` 컬럼
  - `startDate` 컬럼

#### 2.3 Database Configuration
- **파일**: `lib/data/data_source/local/database/database.dart`
- **변경 사항**:
  - `schemaVersion`: 1 → 2
  - `@DriftDatabase` 테이블 목록에 `MoodSummaries` 추가
  - Migration 전략 추가:
    ```dart
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(moodSummaries);
      }
    }
    ```

### 3단계: Data Source (완료)
- **파일**: `lib/data/data_source/local/mood_summary_local_data_source.dart`
- **주요 메서드**:
  - `getLatestSummaryByPeriod()`: 주기별 최신 결산 조회
  - `getSummariesByPeriod()`: 주기별 결산 목록 조회
  - `insertSummary()`: 결산 저장
  - `deleteSummary()`: 결산 삭제
  - `getSummaryByDateRange()`: 날짜 범위로 조회
  - `getAllSummaries()`: 전체 결산 조회

### 4단계: Repository Implementation (완료)

#### 4.1 MoodSummaryRepository
- **파일**: `lib/data/repositories/mood_summary_repository_impl.dart`
- **기능**: Local Data Source를 사용한 Repository 구현
- **에러 처리**: try-catch로 모든 작업 감싸고 Result 패턴 반환

#### 4.2 GeminiRepository
- **파일**: `lib/data/repositories/gemini_repository_impl.dart`
- **모델**: Firebase AI의 Gemini 1.5 Flash 사용
- **프롬프트 구조**:
  - 역할 정의: "감정 분석 전문가"
  - 데이터 요약: 체크인 정보 정리 (날짜, 기분, 감정, 활동, 메모)
  - 분석 요청: 5가지 항목 (감정 흐름, 주요 감정, 활동 패턴, 조언, 주목할 점)
  - 응답 형식: JSON
  - 톤: 공감적이고 따뜻한 한국어
- **응답 파싱**: JSON 추출 및 각 필드별 파싱

## 🔄 다음 작업 (진행 예정)

### 5단계: Presentation Layer
- `MoodSummaryViewModel` 생성
- 전용 화면 (view, content) 생성
- 홈 화면 카드 위젯 (일간/주간/월간)

### 6단계: 통합 및 설정
- Routes 및 Router 설정
- Drawer 메뉴에 항목 추가
- DI Container 설정
- 자동 생성 로직 통합
- 다국어 지원 추가

### 7단계: 테스트 및 최적화
- build_runner 실행
- 기능 테스트
- 버그 수정

## 📝 기술적 결정사항

1. **아키텍처**: Clean Architecture + MVVM 패턴 유지
2. **상태 관리**: Provider 사용
3. **데이터 저장**: Drift (SQLite) 로컬 DB
4. **불변성**: Freezed 패키지 사용
5. **에러 처리**: Result 패턴 사용
6. **자동 생성**: 앱 시작 시 주기별 검사 후 자동 생성

## 🔍 주요 고려사항

- 통계 화면(`statistics_view.dart`)은 수정하지 않음
- 주간/월간 결산은 향후 프리미엄 기능 전환 가능성 고려
- 네트워크 오류 시 graceful degradation
- 토큰 사용량 최적화를 위한 데이터 요약 전송

## 📅 작업 일자
- 시작일: 2025-10-28
- 마지막 업데이트: 2025-10-28

## 📊 진행률
- 전체: 50% (7/14 단계 완료)
- Domain Layer: 100% ✅
- Data Layer: 100% ✅
- Presentation Layer: 0%
- Integration: 0%
