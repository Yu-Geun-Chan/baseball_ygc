## 🗂 README 목차
1. 프로젝트 개요
2. 개발기간
3. 팀원 및 담당파트
4. 사용기술 및 개발환경
5. ERD 구조
6. 기능
7. 페이지별 기능 설명
8. KLC 환경설정 가이드북

---

## 📌 프로젝트 소개
- KLC는 KBO리그(한국프로야구)를 좋아하는 팬들 뿐만 아니라 입문하는 사람들도 편하게 이용할 수 있는 커뮤니티 사이트입니다.
- 또한 KBO리그와 관련된 소식들과 간단한 정보들을 제공하는 사이트이기도 합니다.

### 주제 선정 동기
- 제가 야구를 좋아하기도 하고,  단순한 커뮤니티 사이트가 아닌 KBO의 간단한 정보까지 같이 다룬다면 편리할거 같아서 진행하게 되었습니다.

---

### 📅 개발 기간
- 2024-08-20 ~2024-10.01

---

### 👥 팀원 & 담당파트
- 유근찬 : 전체(개인프로젝트)
  - ✉ geunchan9055@gmail.com
  
---

### 🛠 사용기술 및 개발환경
- 개발환경
  - Window 10, JDK, MAVEN, Spring Tool Suit 4
  - 웹-프레임워크 : 구글 앱 스크립트
- 언어
  - JAVA
- FE
  - HTML, CSS, JavaScript,jQuery
- BE
  - 프레임워크 : SpringBoot, Selenium
  - 라이브러리 : Lombok, Tomcat
  - 템플릿 엔진 : JSP
  - ORM : MyBatis
- API
  - OpenWeather API
  - Kakao Maps 
- DB
  - MySQL
  - 쿼리 브라우저 : SQLyog
- 버전 관리
  - Git
  - GitHub
- 디자인
  - Figma
- ERD
  - ErdCloud 
  - [해당 링크](https://www.erdcloud.com/d/fTaZYRNyvibGAob3Z)
---

## 🖇ERD 구조
![](https://velog.velcdn.com/images/da5105/post/43fc86bf-ed91-47ee-9bb7-9c68b2738584/image.png)

---

## ⚙ 기능
- 회원가입, 로그인/로그아웃, 개인정보 수정, 탈퇴
- 마이페이지(응원 선수 및 메세지 확인)
- 경기 일정 조회 [정규시즌 일정, 포스트 시즌 일정]
- 경기장 날씨 조회 [10분 마다 최신 날씨로 갱신]
- 구단 순위 조회 [현재 날짜 기준]
- 구장 정보 조회 [구단 로고 눌렀을 때 구장 위치 지도에 표시, 필터로 편의시설 위치 노출]
- 금일 KBO 기사 [구단 로고 눌렀을 때 해당하는 구단의 기사 노출]
- 선수 조회 [구단, 포지션, 이름별로 검색 가능]
- 선수 상세정보 조회 [선수 사진, 소속구단명, 이름, 포지션, 기록]
- 커뮤니티 게시판 CRUD, 게시글 좋아요/싫어요, 댓글 비동기 처리
- 문의사항 이메일 발송

---

## 💡 페이지별 기능 설명

### 메인페이지

![](https://velog.velcdn.com/images/da5105/post/fbe419cb-44cf-4234-888d-538cafe9063a/image.png)
- 메인 페이지를 통해 KLC에 있는 기능들을 소개합니다. (횡 스크롤로 이동 가능)
- 아래쪽 구단 로고를 누르면 해당하는 구단의 홈페이지로 이동합니다.
- 아래쪽 SNS 아이콘은 KBO(한국프로야구협회)가 운영하는 SNS 페이지로 이동합니다.

### 회원 관련 페이지
[로그인 / 로그아웃]

![](https://velog.velcdn.com/images/da5105/post/9d4d042f-1687-4081-b3a0-3a11aaabe168/image.png)

[회원가입]

![](https://velog.velcdn.com/images/da5105/post/47d42e59-9ed3-4b24-9bb6-a2c895952553/image.png)

[회원정보] : 회원 탈퇴 및 수정 기능 제공

![](https://velog.velcdn.com/images/da5105/post/46cc41ab-8c85-44b4-9ebd-db6f7891cd85/image.png)

[마이 페이지] : 응원선수 선택 및 응원메세지 입력 기능 제공

![](https://velog.velcdn.com/images/da5105/post/6129d8db-60aa-4734-82be-b8d182fe9376/image.png)

### 경기일정 페이지
[초기 페이지]

![](https://velog.velcdn.com/images/da5105/post/0da5fb1d-09a0-42cb-8172-378b8c36293c/image.png)

[10월, 포스트시즌 선택한 상태]

![](https://velog.velcdn.com/images/da5105/post/5c025487-96fd-4a05-b364-8f12577c856e/image.png)
- 전체 일정을 조회할 수 있는 페이지
	- 초기 설정 값은 당월, KBO 정규시즌 일정이 선택되어있는 상태
		- 월별, 시리즈 별로 경기일정을 조회할 수 있습니다.

    
### 구단순위 페이지
[초기 페이지]

![](https://velog.velcdn.com/images/da5105/post/d3869af5-3898-4a37-bf6f-abebfba67864/image.png)

[현재날짜 기준 구단 순위]

![](https://velog.velcdn.com/images/da5105/post/a29e5dad-5a5d-46ec-b08a-21bb9cc1a252/image.png)
- 현재날짜 기준의 구단순위를 조회할 수 있는 페이지

### 구장날씨 페이지
![](https://velog.velcdn.com/images/da5105/post/d41377a3-cc9c-450a-af86-f2a87feeb7cc/image.png)


- 구장 날씨를 조회할 수 있는 페이지
	- 10분 마다 새로운 정보로 갱신
		- 해당하는 구단의 로고를 상단에 노출시켜 명확성 향상
    
### 구장정보 페이지

[초기 페이지]

![](https://velog.velcdn.com/images/da5105/post/88fb28d3-b1f6-4900-a34d-53cf9a547e02/image.png)

[구단 로고 클릭 시]

![](https://velog.velcdn.com/images/da5105/post/7b847b8f-ed0e-41b2-b032-dbb1585321cb/image.png)

[‘찾아가기’ 클릭 시]

![](https://velog.velcdn.com/images/da5105/post/8a992dbe-ded0-4574-9d2a-2a1e5c244fab/image.png)

[편의시설 필터 클릭 시]

![](https://velog.velcdn.com/images/da5105/post/41ef6a88-ed1d-4bea-9015-24659e2c8c1d/image.png)

- 구단 로고 클릭 시 해당 구단의 홈 구장 정보 제공
- ‘찾아가기’ 버튼 클릭 시 지도에 구장 위치 마커 표시
- 편의시설 필터 버튼 클릭 시 편의점, 카페 등 편의시설 위치 표시

### 금일 KBO 기사 페이지

[초기 페이지]

![](https://velog.velcdn.com/images/da5105/post/68a45f3c-3141-4275-b3b8-1bb719477266/image.png)

[전체 구단 뉴스]

![](https://velog.velcdn.com/images/da5105/post/e70820f6-385f-4335-89b2-3fd24133fb38/image.png)

[LG 구단 뉴스]

![](https://velog.velcdn.com/images/da5105/post/34269200-7098-445f-bc64-9404fd2c5d97/image.png)


- 금일 KBO 전체 뉴스 제공
- 우측 상단 ‘전체 뉴스 보기’ 클릭 시 네이버 스포츠 야구 뉴스 페이지로 이동
- 구단 로고 클릭 시 해당하는 구단의 뉴스만 제공
	- 참고사항 : 좌측 KBO 로고는 전체 구단 뉴스 제공
		- ex) LG 구단 로고 클릭 시 LG 구단에 해당하는 뉴스만 제공


### 선수 조회 및 정보 페이지

[초기 페이지]

![](https://velog.velcdn.com/images/da5105/post/23485da0-808e-4545-84b8-44998bb0ee56/image.png)

[구단 ‘KIA’ 선택 ]

![](https://velog.velcdn.com/images/da5105/post/6fed51be-3c55-4b58-96ef-10cddbc836f1/image.png)

[포지션 ‘투수’ 선택]

![](https://velog.velcdn.com/images/da5105/post/7b26ab31-a889-40a4-a937-8aceff4d6d47/image.png)

[이름 ‘노시환’  검색]

![](https://velog.velcdn.com/images/da5105/post/aa333a98-5877-4099-b783-2252f485256a/image.png)![](https://velog.velcdn.com/images/da5105/post/bda6cbe0-d7aa-4390-bf41-ea269a360d9a/image.png)

- 구단, 포지션, 선수이름으로 선수를 조회 할 수 있는 페이지
- 선수 이름을 클릭하면 해당하는 선수의 정보를 볼 수 있다.

### 문의사항 페이지

[초기 페이지]

![](https://velog.velcdn.com/images/da5105/post/8c88121e-ce5e-42d0-8031-64447cd9a8ee/image.png)

[‘문의하기’ 클릭 시]

![](https://velog.velcdn.com/images/da5105/post/e2538e60-79c0-4cf5-ac8d-68edb4c28c22/image.png)


- 관리자에게 문의사항을 이메일로 보낼 수 있는 페이지
	- ‘문의하기’ 클릭 시 알람창으로 이메일을 보냈다고 알려준다.

---

## 📑 KLC 환경설정 가이드 북

![](https://velog.velcdn.com/images/da5105/post/8560c84e-0a07-438d-bbeb-f7e6723ad121/image.png)

![](https://velog.velcdn.com/images/da5105/post/50896370-b68a-46f5-9b71-c1a77d6ab326/image.png)

![](https://velog.velcdn.com/images/da5105/post/055e280c-a286-4cfa-bc63-20ca7d52078b/image.png)

![](https://velog.velcdn.com/images/da5105/post/e27de4cd-2377-4415-892b-93e29ce0b424/image.png)

![](https://velog.velcdn.com/images/da5105/post/95b5c63d-668b-4b9b-b53f-c293b19d961d/image.png)

![](https://velog.velcdn.com/images/da5105/post/adedd312-dcc7-48e0-971c-e9f207751ac0/image.png)





