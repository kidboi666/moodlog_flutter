# 커밋 컨벤션

## 커밋 메시지 형식

```
<타입>(<스코프>): <제목>

<본문>

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## 타입 (Type)

- **feat**: 새로운 기능 추가
- **fix**: 버그 수정
- **refactor**: 코드 리팩토링 (기능 변경 없음)
- **style**: 코드 스타일 변경 (포맷팅, 세미콜론 등)
- **chore**: 빌드, 설정 파일 수정
- **docs**: 문서 수정
- **test**: 테스트 코드 추가/수정
- **perf**: 성능 개선

## 스코프 (Scope)

변경 영역을 나타내는 선택적 식별자:

- `font`: 폰트 관련
- `settings`: 설정 화면
- `theme`: 테마/디자인
- `ai`: AI 기능
- `backup`: 백업/복원
- `auth`: 인증/보안
- `ui`: UI 컴포넌트
- `navigation`: 라우팅/네비게이션
- `data`: 데이터 레이어
- `refactor`: 리팩토링
- `android`: Android 플랫폼
- `ios`: iOS 플랫폼

## 제목 (Subject)

- **한글로 작성**
- 50자 이내로 간결하게
- 명령문 형태 (예: "추가", "수정", "제거")
- 마침표(.) 사용하지 않음

## 본문 (Body)

- 상세한 변경사항 설명
- 불렛 포인트(`-`)로 주요 변경사항 나열
- 왜(why) 변경했는지, 어떻게(how) 변경했는지 설명
- 관련 기술적 세부사항 포함

## 예시

### 기능 추가
```
feat(font): Google Fonts 연동 및 폰트 시스템 리팩토링

- **`FontType` 도입**:
    - 기존 `FontFamily` enum을 `FontType` sealed class로 대체하여 시스템 폰트와 Google Fonts를 함께 관리
    - `FontTypeSerializer` 추가하여 직렬화/역직렬화 로직 구현

- **Google Fonts 연동 기능 추가**:
    - Google Fonts API 또는 로컬 JSON을 통해 폰트 목록을 가져오는 `GoogleFontsRepository` 구현
    - API 요청 실패 시 로컬 에셋으로 대체(fallback)하여 안정성 확보

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### 리팩토링
```
refactor(usecase): `WriteJournalUseCase`를 도입하여 관련 로직 통합

- 일기 작성 관련 분산된 로직을 `WriteJournalUseCase`로 통합
- 코드 재사용성 향상 및 유지보수 용이성 개선

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### 버그 수정
```
fix(backup): 통계 데이터 없이도 백업/복원되도록 수정

- 통계 데이터가 없을 때 백업 실패하던 문제 해결
- 선택적 필드로 변경하여 안정성 향상

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## 주의사항

- 각 커밋은 하나의 논리적 변경사항만 포함
- 관련 없는 변경사항은 별도 커밋으로 분리
- 커밋 전 `flutter analyze` 실행하여 오류 확인
- 기능 단위로 중간중간 커밋하여 히스토리 추적 용이하게 유지
