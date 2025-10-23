# 데이터베이스 스키마

## 개요

- **ORM:** Drift (SQLite)
- **파일명:** `moodlog_v2.db`
- **스키마 버전:** v1

## 테이블 구조

### CheckIns (체크인)
빠른 기분 기록용 테이블

```sql
CREATE TABLE check_ins (
  id INTEGER PRIMARY KEY,
  created_at DATETIME NOT NULL,
  mood_type INTEGER NOT NULL,  -- veryHappy(0)~verySad(4)
  sleep_quality INTEGER,        -- 1~5
  emotion_names TEXT,            -- JSON array
  tag_names TEXT,                -- JSON array
  memo TEXT,
  latitude REAL,
  longitude REAL,
  address TEXT,
  temperature REAL,
  weather_icon TEXT,
  weather_description TEXT
);
CREATE INDEX check_ins_created_at ON check_ins(created_at);
```

### Journals (일기)
상세 일기 작성용 테이블

```sql
CREATE TABLE journals (
  id INTEGER PRIMARY KEY,
  created_at DATETIME NOT NULL,
  content TEXT NOT NULL,
  image_uri TEXT,               -- JSON array
  latitude REAL,
  longitude REAL,
  address TEXT,
  temperature REAL,
  weather_icon TEXT,
  weather_description TEXT
);
CREATE INDEX journals_created_at ON journals(created_at);
```

### Tags (태그)
체크인 태그 마스터 테이블

```sql
CREATE TABLE tags (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,           -- max 50자
  color TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX tags_name ON tags(name);
```

### Emotions (감정)
체크인 감정 마스터 테이블

```sql
CREATE TABLE emotions (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,           -- max 50자
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX emotions_name ON emotions(name);
```

### CheckInTags (체크인-태그 매핑)
```sql
CREATE TABLE check_in_tags (
  id INTEGER PRIMARY KEY,
  check_in_id INTEGER NOT NULL REFERENCES check_ins(id) ON DELETE CASCADE,
  tag_id INTEGER NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(check_in_id, tag_id)
);
CREATE INDEX check_in_tags_check_in_id ON check_in_tags(check_in_id);
CREATE INDEX check_in_tags_tag_id ON check_in_tags(tag_id);
```

### CheckInEmotions (체크인-감정 매핑)
```sql
CREATE TABLE check_in_emotions (
  id INTEGER PRIMARY KEY,
  check_in_id INTEGER NOT NULL REFERENCES check_ins(id) ON DELETE CASCADE,
  emotion_id INTEGER NOT NULL REFERENCES emotions(id) ON DELETE CASCADE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(check_in_id, emotion_id)
);
CREATE INDEX check_in_emotions_check_in_id ON check_in_emotions(check_in_id);
CREATE INDEX check_in_emotions_emotion_id ON check_in_emotions(emotion_id);
```

### Stats (통계)
```sql
CREATE TABLE stats (
  id INTEGER PRIMARY KEY,
  current_streak INTEGER DEFAULT 0,
  max_streak INTEGER DEFAULT 0,
  last_active_date DATETIME NOT NULL
);
```

## ER 다이어그램

```
CheckIns ──┬─< CheckInTags >── Tags
           │
           └─< CheckInEmotions >── Emotions

Journals (독립)

Stats (독립)
```

## 주요 특징

1. **체크인/일기 분리**: 빠른 기록(CheckIns) vs 상세 기록(Journals)
2. **정규화**: 태그/감정을 재사용 가능한 마스터 테이블로 관리
3. **CASCADE 삭제**: 체크인 삭제 시 관련 매핑 자동 삭제
4. **날짜 인덱스**: `created_at` 인덱스로 날짜별 조회 최적화
5. **중복 방지**: 매핑 테이블에 UNIQUE 제약조건

## 데이터 접근 계층

- **DataSource**: `lib/data/data_source/local/`
  - `check_in_local_data_source.dart`
  - `journal_local_data_source.dart`
  - `tag_local_data_source.dart`
  - `emotion_local_data_source.dart`

- **Repository**: `lib/data/repositories/`
  - `check_in_repository_impl.dart`
  - `journal_repository_impl.dart`

- **Schema**: `lib/data/data_source/local/database/schema.dart`
