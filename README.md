# swag_cross_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 폴더 구조

#### assets : 이미지나 비디오 파일을 넣는곳

- images : 이미지
- videos : 비디오

#### features : 기능(프로젝트 코드들을 기능별로 나누었다)

- alert : 알림
- community : 커뮤니티
- main_navigation : 하단 메뉴바
- customer_service : 고객센터
- page_test : 테스트
- search_page : 검색
- sign_in_up : 로그인, 회원가입
- user_profile : 내정보관리
- widget_tools : 자주사용하는 커스텀위젯

#### constants : 자주 쓰는 위젯들을 변수화 시킨것

#### models : 앱 내부에서 쓰는 모델들을 모아놓은곳

#### storages : 클라이언트에 저장되는 스토리지(암호화)

#### utils : 라이브러리를 간단하게 사용하기 위한 파일을 모아놓은곳

## 라이브러리

- font_awesome_flutter: 10.3.0 (무료 이미지 라이브러리)
- http: 0.13.5 (통신)
- get: 4.6.5 (라우트, 상태관리 등 기능)
- cupertino_icons: 1.0.2 (안드로이드 스타일 아이콘 라이브러리)
- flutter_naver_login: 1.7.0 (네이버 아이디 로그인 라이브러리)
- flutter_secure_storage: 8.0.0 (로컬 스토리지를 만드는 라이브러리)
- table_calendar: 3.0.9 (달력 라이브러리)
- intl: 0.18.0 (메시지 번역, 복수형 및 성별, 날짜/숫자 형식 지정 및 구문 분석, 양방향 텍스트를 포함한 국제화 및 현지화 기능을 제공)
- google_mobile_ads: 2.3.0 (구글 광고 라이브러리)
- provider: 6.0.5 (상태 관리 라이브러리)
- go_router: ^6.5.5 (라우터 페이지 관리 라이브러리)
- carousel_slider: ^4.2.1 (슬라이드 라이브러리)
- image_picker: ^1.0.0 (갤러리, 카메라 라이브러리)
