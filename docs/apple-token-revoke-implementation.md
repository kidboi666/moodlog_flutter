# Apple 회원 탈퇴 기능 구현

웹 문서 (https://velog.io/@tygerhwang/Flutter-Apple-로그인-A-to-Z-로그인-인증-그리고-탈퇴-처리#revoking-apple-login-tokens)의 방법을 기반으로 Apple 계정 탈퇴 기능을 구현했습니다.

## 구현된 기능

### 1. JWT 기반 Client Secret 생성
- `lib/core/utils/jwt_utils.dart`에 `createAppleClientSecret()` 메서드 추가
- ES256 알고리즘을 사용한 JWT 토큰 생성
- 환경 변수에서 Apple Team ID, Key ID, Client ID, Private Key 읽기

### 2. Apple 토큰 철회 API 구현
- `AuthRepository`에 `revokeAppleTokenWithAPI()` 메서드 추가
- Apple의 REST API (`https://appleid.apple.com/auth/revoke`) 직접 호출
- JWT Client Secret을 사용한 인증

### 3. 회원 탈퇴 시 통합된 토큰 철회 처리
- 기존 Firebase의 `revokeTokenWithAuthorizationCode` 방식 유지
- Firebase 방식 실패 시 대체 방안 준비
- 사용자에게 수동 연동 해제 가이드 제공

### 4. 에러 처리 및 안전장치
- 네트워크 타임아웃 (30초) 설정
- 토큰 철회 실패 시에도 계정 삭제 진행
- 상세한 로깅으로 디버깅 지원

## 설정 방법

### 환경 변수 설정 (.env 파일)
```
APPLE_TEAM_ID=YOUR_TEAM_ID_HERE
APPLE_KEY_ID=YOUR_KEY_ID_HERE
AUTH_CLIENT_ID=com.logmind.moodlog.signin
APPLE_PRIVATE_KEY_LINE1=-----BEGIN PRIVATE KEY-----
APPLE_PRIVATE_KEY_LINE2=... (실제 프라이빗 키 내용)
...
APPLE_PRIVATE_KEY_LINE6=-----END PRIVATE KEY-----
```

### 필요한 값 확인 방법
1. **Team ID**: Apple Developer 계정의 Membership 페이지에서 확인
2. **Key ID**: Sign in with Apple용 키 생성 시 받은 Key ID
3. **Private Key**: .p8 파일의 내용을 여러 줄로 나누어 저장

## 사용법

회원 탈퇴 시 자동으로 다음 순서로 처리됩니다:

1. Apple 사용자 확인
2. Firebase의 `revokeTokenWithAuthorizationCode` 시도
3. 실패 시 사용자에게 수동 해제 가이드 표시
4. 계정 삭제 진행

## 주의사항

- Apple Developer 계정의 Team ID와 Key ID는 실제 값으로 교체 필요
- 프라이빗 키는 보안상 민감한 정보이므로 안전하게 관리
- 토큰 철회가 실패해도 계정 삭제는 진행되도록 설계됨

## 다국어 지원

기존 `.arb` 파일에 다음 키들이 이미 준비되어 있습니다:
- `profile_delete_account_apple_manual_revoke_guide`
- `profile_delete_account_apple_revoke_failed`
- `profile_delete_account_apple_revoke_success`

한국어, 영어, 일본어 모두 지원됩니다.