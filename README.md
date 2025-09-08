# 🌟 MoodLog

> **감정을 기록하고, 마음을 들여다보는 AI 감정 일기 앱**

MoodLog는 일상의 감정을 기록하고 분석하여 더 나은 자신을 만들어가는 여정을 돕는 Flutter 기반 크로스플랫폼 앱입니다.

<a href="https://play.google.com/store/apps/details?id=com.kidboi666.moodlog">
  <img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" alt="Get it on Google Play" width="150">
</a>

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)

## 📱 스크린샷

<table>
  <tr>
    <td><img width="295" height="639" alt="Simulator Screenshot 1" src="https://github.com/user-attachments/assets/dbcddcd5-5928-4572-8b91-3a2f98fd226d" /></td>
    <td><img width="295" height="639" alt="Simulator Screenshot 2" src="https://github.com/user-attachments/assets/61aa82f0-0da1-419a-ad50-be48df805ac7" /></td>
    <td><img width="295" height="639" alt="Simulator Screenshot 3" src="https://github.com/user-attachments/assets/18881eeb-ebc2-4a51-9876-80aaae5e1a79" /></td>
  </tr>
  <tr>
    <td><img width="295" height="639" alt="Simulator Screenshot 4" src="https://github.com/user-attachments/assets/53e2e39b-b608-4270-933d-e1019f18afd8" /></td>
    <td><img width="295" height="639" alt="Simulator Screenshot 5" src="https://github.com/user-attachments/assets/bc6fdecc-d644-465c-ba57-0e6e34e14ac6" /></td>
    <td><img width="295" height="639" alt="Simulator Screenshot 6" src="https://github.com/user-attachments/assets/bbd60fc4-1259-4e95-b619-69e2a210d60c" /></td>
  </tr>
</table>

## ✨ 주요 기능

### 📝 **스마트 감정 기록**
- 5단계 감정 선택으로 간편한 기록
- 이미지, 위치, 날씨 정보 자동 연동
- 태그 시스템으로 체계적인 분류

### 🤖 **AI 위로 메시지**
- Gemini AI가 제공하는 개인 맞춤형 위로와 격려
- 일기 내용을 분석한 공감적 응답
- 하루 1회 제한으로 특별함 유지

### 📊 **인사이트풀한 통계**
- GitHub 스타일 연간 활동 히트맵
- 감정 분포 및 트렌드 분석
- 연속 기록 달성 현황 추적
- 대표 감정 및 평균 점수 계산

### 🌍 **글로벌 접근성**
- **9개 언어 지원**: 한국어, 영어, 일본어, 중국어, 스페인어, 이탈리아어, 프랑스어, 베트남어, 태국어
- 다양한 폰트 옵션 (프리텐다드, 이서윤체, 나눔손글씨 등)
- 라이트/다크 테마 자동 전환

### 🔐 **안전한 데이터 관리**
- Firebase 기반 클라우드 동기화
- Google/Kakao 소셜 로그인
- 게스트 모드 지원

## 🏗️ 기술 스택

### **Frontend**
- **Flutter** - 크로스플랫폼 UI 프레임워크
- **Dart** - 프로그래밍 언어
- **Provider** - 상태 관리
- **Go Router** - 선언적 라우팅

### **Backend & Services**
- **Firebase Auth** - 사용자 인증
- **Firebase Firestore** - NoSQL 데이터베이스
- **Firebase Analytics** - 사용자 분석
- **Google Gemini AI** - AI 응답 생성

### **External APIs**
- **Geolocator** - 위치 서비스
- **Weather API** - 날씨 정보
- **Image Picker** - 갤러리 접근

## 🏛️ 아키텍처

MoodLog는 **Clean Architecture** 패턴을 적용하여 확장 가능하고 유지보수가 용이한 구조로 설계되었습니다.

```
lib/
├── core/                    # 공통 유틸리티 및 상수
│   ├── constants/          # 앱 전역 상수
│   ├── l10n/              # 다국어 지원
│   ├── providers/         # 글로벌 상태 관리
│   ├── routing/           # 라우팅 설정
│   ├── ui/                # 공통 UI 컴포넌트
│   └── utils/             # 헬퍼 함수들
├── data/                   # 데이터 계층
│   ├── data_source/       # 로컬/원격 데이터 소스
│   └── repositories/      # Repository 구현체
├── domain/                 # 도메인 계층
│   ├── entities/          # 비즈니스 엔티티
│   ├── repositories/      # Repository 인터페이스
│   └── use_cases/         # 비즈니스 로직
└── presentation/          # 프레젠테이션 계층
    ├── home/              # 홈 화면
    ├── entries/           # 일기 목록
    ├── write/             # 일기 작성
    ├── statistics/        # 통계 화면
    └── settings/          # 설정 화면
```

### **Design Patterns**
- **MVVM (Model-View-ViewModel)** - UI와 비즈니스 로직 분리
- **Repository Pattern** - 데이터 소스 추상화
- **UseCase Pattern** - 비즈니스 로직 캡슐화
- **Provider Pattern** - 반응형 상태 관리

## 🚀 시작하기

### **사전 요구사항**
- Flutter SDK (3.0.0 이상)
- Dart SDK (3.0.0 이상)
- Android Studio / VS Code
- Firebase 프로젝트 설정

### **설치 및 실행**

1. **저장소 클론**
```bash
git clone https://github.com/your-username/moodlog.git
cd moodlog
```

2. **의존성 설치**
```bash
flutter pub get
```

3. **Firebase 설정**
```bash
# Firebase CLI 설치 후
firebase login
flutterfire configure
```

4. **코드 생성**
```bash
flutter packages pub run build_runner build
```

5. **앱 실행**
```bash
flutter run
```

### **빌드**
```bash
# Android APK
flutter build apk --release

# iOS IPA
flutter build ios --release

# Web
flutter build web
```

## 📱 스크린샷

### 메인 화면
| 홈 | 일기 작성 | 통계 |
|:---:|:---:|:---:|
| 감정 현황과 최근 기록 | AI 위로 메시지 포함 | 연간 활동 히트맵 |

### 다국어 지원
| 한국어 | English | 日本語 |
|:---:|:---:|:---:|
| 기본 언어 | 글로벌 사용자 | 일본 사용자 |

## 🎯 로드맵

### **v1.1 (예정)**
- [ ] 오프라인 모드 지원
- [ ] 데이터 내보내기/가져오기
- [ ] 위젯 지원

### **v1.2 (예정)**
- [ ] 머신러닝 기반 감정 패턴 분석
- [ ] 알림 시스템 개선
- [ ] 소셜 기능 (익명 커뮤니티)

### **v2.0 (장기)**
- [ ] 웨어러블 디바이스 연동
- [ ] 음성 인식 일기 작성
- [ ] 전문가 상담 연결

## 🤝 기여하기

MoodLog 프로젝트에 기여해주시는 모든 분들을 환영합니다!

### **기여 방법**
1. 이슈 생성 또는 기존 이슈 확인
2. Fork 후 feature 브랜치 생성
3. 코드 작성 및 테스트
4. Pull Request 생성

### **개발 가이드라인**
- **코드 스타일**: `dart format` 및 `dart analyze` 준수
- **커밋 메시지**: [Conventional Commits](https://conventionalcommits.org/) 형식
- **테스트**: 새로운 기능은 테스트 코드 포함

## 👥 팀

- **개발자**: logmind 
- **이메일**: log.mind.365@gmail.com
- **GitHub**: [@kidboi666](https://github.com/kidboi666/moodlog)

## 🙏 감사의 말

- [Flutter 팀](https://flutter.dev)의 훌륭한 프레임워크
- [Firebase](https://firebase.google.com)의 강력한 백엔드 서비스
- [Material Design](https://material.io)의 아름다운 디자인 시스템
- 모든 오픈소스 기여자들

---

**MoodLog와 함께 당신의 감정 여행을 시작해보세요! 🌈**

