# TODO 주석 분석 및 우선순위 정리

## 📋 발견된 TODO 항목들

### 🔥 High Priority (즉시 처리 필요)

#### 1. **미구현 기능**
- `lib/data/repositories/gemini_repository_impl.dart:58` - `updatePersonality` 메서드 미구현
  - **영향**: AI 성격 변경 기능이 작동하지 않을 수 있음
  - **우선순위**: 높음
  - **예상 작업시간**: 2-4시간

### 🚧 Medium Priority (단기 계획 필요)

#### 1. **설정 기능들**
- `lib/presentation/settings/settings_screen_content.dart:40` - 알림 On/Off 기능
- `lib/presentation/settings/settings_screen_content.dart:92` - 데이터 자동 백업 On/Off 기능
- `lib/presentation/settings/settings_viewmodel.dart:144` - 백업 기능
- `lib/presentation/settings/settings_screen_content.dart:132` - FAQ 웹뷰 이동 기능
  - **영향**: 사용자 편의 기능 부족
  - **우선순위**: 중간
  - **예상 작업시간**: 각 1-2일

### 💰 Business Decision Required (비즈니스 의사결정 필요)

#### 1. **Firebase 요금제 관련 기능들**
- `lib/presentation/profile/widgets/profile_avatar.dart:20,29,33` - 프로필 이미지 관련 기능들
- `lib/presentation/profile/profile_viewmodel.dart:61` - 프로필 이미지 기능
- `lib/core/ui/widgets/image_screen_with_button.dart:26` - 프로필 이미지 확대 기능
  - **영향**: 사용자 프로필 개인화 기능 제한
  - **우선순위**: 낮음 (비즈니스 의사결정 대기)
  - **의존성**: Firebase 요금제 업그레이드 결정

### ⚙️ Low Priority (시스템/설정 파일)

#### 1. **빌드 설정 관련**
- `android/app/build.gradle.kts:36` - Application ID 설정
- `windows/flutter/CMakeLists.txt:9` - Windows 빌드 설정
- `linux/flutter/CMakeLists.txt:9` - Linux 빌드 설정
  - **영향**: 개발 환경 설정
  - **우선순위**: 낮음
  - **비고**: 플랫폼별 배포 시 처리

## 📊 통계 요약

- **총 TODO 개수**: 12개 (Git hooks 제외)
- **High Priority**: 1개
- **Medium Priority**: 4개
- **Business Decision Required**: 5개
- **Low Priority**: 3개

## 🎯 권장 처리 순서

### Phase 1: 즉시 처리 (이번 주)
1. `gemini_repository_impl.dart` - `updatePersonality` 메서드 구현

### Phase 2: 단기 계획 (1-2주)
1. 알림 On/Off 기능 구현
2. FAQ 웹뷰 기능 구현
3. 데이터 자동 백업 기능 구현
4. 백업 기능 구현

### Phase 3: 비즈니스 의사결정 대기
1. Firebase 요금제 업그레이드 여부 결정
2. 프로필 이미지 관련 기능들 구현 여부 결정

### Phase 4: 시스템 유지보수
1. 플랫폼별 빌드 설정 최적화
2. Application ID 정리

## 🚨 주의사항

### 미구현 기능 관련
- `updatePersonality` 메서드가 구현되지 않아 AI 성격 변경이 실제로 작동하지 않을 수 있음
- 사용자에게 혼란을 줄 수 있으므로 우선 처리 필요

### 비즈니스 기능 관련
- Firebase 관련 기능들은 비용이 발생하므로 신중한 결정 필요
- 임시로 기능을 비활성화하거나 대체 방안 검토 필요

### 설정 기능 관련
- 알림, 백업 등의 기능은 사용자 경험에 직접적 영향
- 단계적 구현을 통해 우선순위 높은 것부터 처리

---

**분석 일자**: 2025-09-21
**다음 검토 일정**: 2025-10-05