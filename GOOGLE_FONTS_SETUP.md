# Google Fonts API 설정 가이드

## Google Fonts API 키 발급하기

### 1. Google Cloud Console 접속
https://console.cloud.google.com/ 에 접속합니다.

### 2. 프로젝트 생성 또는 선택
- 기존 프로젝트를 사용하거나 새 프로젝트를 생성합니다.

### 3. Google Fonts API 활성화
1. 좌측 메뉴에서 "API 및 서비스" > "라이브러리" 선택
2. "Google Fonts Developer API" 검색
3. "사용" 버튼 클릭하여 API 활성화

### 4. API 키 생성
1. "API 및 서비스" > "사용자 인증 정보" 선택
2. "+ 사용자 인증 정보 만들기" > "API 키" 선택
3. 생성된 API 키를 복사

### 5. .env 파일에 API 키 추가
```bash
GOOGLE_FONTS_API_KEY=YOUR_API_KEY_HERE
```

위의 `YOUR_API_KEY_HERE` 부분을 복사한 API 키로 교체합니다.

## 작동 방식

### API 키가 설정된 경우
- **1800개 이상**의 모든 Google Fonts를 실시간으로 가져옵니다
- 최신 폰트 목록이 자동으로 업데이트됩니다
- 인터넷 연결이 필요합니다

### API 키가 없거나 실패한 경우
- **200개**의 인기 폰트가 포함된 로컬 JSON 파일을 사용합니다
- 오프라인에서도 작동합니다
- API 요청 실패 시 자동으로 폴백됩니다

## API 할당량
- Google Fonts API는 무료로 사용 가능합니다
- 일일 요청 제한: 기본적으로 충분한 할당량 제공
- 자세한 내용: https://developers.google.com/fonts/docs/developer_api

## 보안 참고사항
- `.env` 파일은 절대 Git에 커밋하지 마세요
- `.gitignore`에 `.env`가 포함되어 있는지 확인하세요
