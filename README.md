# 프로젝트 정보

<a><img src="https://img.shields.io/badge/-Flutter-387ADF?style=flat-plastic&logo=Flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/-Provider-FBA834?style=flat-plastic&logo=Provider&logoColor=white"/>
<img src="https://img.shields.io/badge/-Github-black?style=flat-plastic&logo=Github&logoColor=white"/></a>

개발자 : 이재현


프로젝트 한줄소개 : 학교에서 키오스크에서 구매하는 학식권을 모바일에서 구매하고 이를 인증할 수 있는 프로그램


프로젝트 화면 구조
- 로그인 / 회원가입
- 날짜별 식단표 출력
- 식권 구매
- 구매한 식권을 QR로 표시
- 결제 내역 표시

## 폴더 구조

- lib : 코드 파일이 위치해 있는곳
-- 하하
- assets : 이미지나 비디오 파일을 넣는곳
- features : 기능 별로 파일/폴더 생성
- constants : 정적으로 생성한 클래스들이 위치한 곳
- models : 앱 내부에서 쓰는 모델들을 모아놓은곳
- storages : 클라이언트에 저장되는 스토리지(암호화)
- utils : 라이브러리를 간단하게 사용하기 위한 파일을 모아놓은곳

## 라이브러리

- cupertino_icons: ^1.0.6 (애플 스타일 아이콘)
- font_awesome_flutter: ^10.7.0 (기본 아이콘)
- http: ^1.2.1 (통신)
- flutter_secure_storage: ^9.0.0 (AES 스토리지)
- provider: ^6.1.2 (상태 관리)
- go_router: ^13.2.2 (라우터 페이지 관리)
- intl: ^0.19.0 (날짜, 단위 포맷)
- flutter_localization: ^0.2.0 (한국어 적용)
- gap: ^3.0.1 (Gap)
- iamport_flutter: ^0.10.18 (아임포트 결제 관리)

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

- font_awesome_flutter: 10.3.0 (기본 아이콘)
- http: 0.13.5 (통신)
- cupertino_icons: 1.0.2 (iOS 스타일 아이콘)
- flutter_naver_login: 1.7.0 (네이버 아이디 로그인)
- flutter_secure_storage: 8.0.0 (AES 보안 스토리지)
- intl: 0.18.0 (메시지 번역, 복수형 및 성별, 날짜/숫자 형식 지정 및 구문 분석, 양방향 텍스트를 포함한 국제화 및 현지화 기능을 제공)
- google_mobile_ads: 2.3.0 (구글 광고)
- provider: 6.0.5 (상태 관리)
- go_router: ^6.5.5 (라우터 페이지 관리)
- carousel_slider: ^4.2.1 (슬라이드)
- image_picker: ^1.0.0 (갤러리, 카메라)
- google_maps_flutter: ^2.3.1 (구글 맵)
- geolocator: ^9.0.2 (위도, 경도)
- flutter_localization: ^0.1.13 (한국어 적용)
