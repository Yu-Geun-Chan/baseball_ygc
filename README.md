## 🗂 README 목차
1. 프로젝트 소개
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
- 2024-08-20 ~ 2024-10.01

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

**✔ [로그인/로그아웃]**

![](https://velog.velcdn.com/images/da5105/post/24bc778b-b774-46aa-a1e9-172f16e255c0/image.png)

**✔ [회원가입]**

![](https://velog.velcdn.com/images/da5105/post/e516d860-78b2-4658-85b2-15bc28254755/image.png)

**✔ [회원정보]**

![](https://velog.velcdn.com/images/da5105/post/385ec509-6ead-4dba-b79f-51f7a96a38de/image.png)

**✔ [회원정보 수정]**

![](https://velog.velcdn.com/images/da5105/post/61604c79-5166-45da-bbde-926462453072/image.png)

**✔ [회원탈퇴/취소]**

![](https://velog.velcdn.com/images/da5105/post/1f95aace-ca70-444a-9a21-c959dc9995f0/image.gif)

**✔ [마이페이지]**

![](https://velog.velcdn.com/images/da5105/post/180e943b-3fda-45b4-9820-f143a91cbbae/image.png)


- 로그인, 로그아웃, 회원가입 기능 제공
- 회원정보 페이지에서 회원탈퇴 및 취소 가능
- 응원선수 선택 및 응원메세지 입력 기능 제공

### 경기일정 페이지

**✔ [초기상태]**

![](https://velog.velcdn.com/images/da5105/post/bdb84b94-030a-4cbd-8cc4-b1da2daef986/image.png)

**✔ [10월, 포스트시즌 선택]**

![](https://velog.velcdn.com/images/da5105/post/37130443-2b52-4904-89a1-64f46963e335/image.png)


- 전체 일정을 조회할 수 있는 페이지
  - 초기 설정 값은 당월, KBO 정규시즌 일정
  - 월별, 시리즈 별로 경기일정을 조회할 수 있습니다.
    
### 구단순위 페이지

**✔ [초기상태]**

![](https://velog.velcdn.com/images/da5105/post/f38adf17-1f5e-4229-8c9b-117603f06336/image.png)

**✔ [현재날짜 기준 구단순위]**

![](https://velog.velcdn.com/images/da5105/post/4ef6ecc7-1db9-43c8-831b-c171ca2073fa/image.png)

- 현재날짜 기준의 구단순위를 조회할 수 있는 페이지

### 구장날씨 페이지
![](https://velog.velcdn.com/images/da5105/post/07ef9d08-a9af-42c7-8d0b-1c75a1207f49/image.png)

- 구장 날씨를 조회할 수 있는 페이지
  - 10분 마다 새로운 정보로 갱신
  - 해당하는 구단의 로고를 상단에 노출시켜 명확성 향상
    
### 구장정보 페이지

**✔ [초기상태]**

![](https://velog.velcdn.com/images/da5105/post/5ece7f42-07c1-4287-a2c1-9f25606d66da/image.png)

**✔ [구단로고 클릭 시]**

![](https://velog.velcdn.com/images/da5105/post/8c10fb1c-a9b2-4c50-9331-ae1ede4da1d6/image.png)

**✔ ['찾아가기' 버튼 클릭 시]**

![](https://velog.velcdn.com/images/da5105/post/ee102050-27b1-4b73-9aec-69b8e469d037/image.png)

**✔ [편의시설 필터 클릭 시]**

![](https://velog.velcdn.com/images/da5105/post/d23f675f-0a68-4db5-b201-1a036efb61ba/image.png)

**✔ [편의시설 필터를 통해 나온 로고 클릭 시]**

![](https://velog.velcdn.com/images/da5105/post/b8c98253-6114-444d-9ac5-e3763848f133/image.png)

- 구단 로고 클릭 시 해당 구단의 홈 구장 정보 제공
- ‘찾아가기’ 버튼 클릭 시 지도에 구장 위치 마커 표시
- 편의시설 필터 버튼 클릭 시 편의점, 카페 등 편의시설 위치 표시
  - 나타난 로고를 클릭하면 해당하는 가게의 정보가 나온다.

### 금일 KBO 기사 페이지

**✔ [초기상태]**

![](https://velog.velcdn.com/images/da5105/post/02c0fd23-70b0-463f-9c79-5fae7b64d42d/image.png)

**✔ [KBO 전체 기사]**

![](https://velog.velcdn.com/images/da5105/post/5b3cd9c5-ccd2-4837-8366-5ec6d02d3629/image.png)

**✔ ['LG 구단 로고' 클릭 시]**

![](https://velog.velcdn.com/images/da5105/post/2601c0da-df5b-400a-b585-5b409e65b672/image.png)

- 금일 KBO 전체 뉴스 제공
- 우측 상단 ‘전체 뉴스 보기’ 클릭 시 네이버 스포츠 야구 뉴스 페이지로 이동
- 구단 로고 클릭 시 해당하는 구단의 뉴스만 제공
  -  참고사항 : 좌측 KBO 로고는 전체 구단 뉴스 제공
  -  ex) LG 구단 로고 클릭 시 LG 구단에 해당하는 뉴스만 제공


### 선수 조회 및 정보 페이지
**✔ [초기상태]**

![](https://velog.velcdn.com/images/da5105/post/2ccb2a97-f686-40da-a12c-a8855a526a64/image.png)

**✔ [구단 'KIA' 선택 시]**

![](https://velog.velcdn.com/images/da5105/post/9ed4547d-17c6-4570-a8c2-fe774d1fc124/image.png)

**✔ [포지션 '투수' 선택 시]**

![](https://velog.velcdn.com/images/da5105/post/81cdc996-ccd5-421a-b184-6a184ceb2a7b/image.png)

**✔ [이름 '노시환' 검색 시]**

![](https://velog.velcdn.com/images/da5105/post/48444785-04be-453c-a491-e740e015b5e1/image.png)

**✔ [검색된 선수의 이름 클릭 시]**

![](https://velog.velcdn.com/images/da5105/post/80489476-72c8-4ade-b41a-a069218393c5/image.png)

- 구단, 포지션, 선수이름으로 선수를 조회 할 수 있는 페이지
- 선수 이름을 클릭하면 해당하는 선수의 정보를 볼 수 있다.

### 게시글 관련 페이지

**✔ [공지사항 페이지]**

![](https://velog.velcdn.com/images/da5105/post/c4fa550a-905f-4474-af55-15371dfd9bd2/image.png)

**✔ [자유게시판 페이지]**

![](https://velog.velcdn.com/images/da5105/post/b603bc2e-8a27-43d8-9e3f-82435aa7e1c8/image.png)

**✔ [게시글 작성]**

![](https://velog.velcdn.com/images/da5105/post/ac9d2098-f707-4f55-b161-e9eeeddb719e/image.png)

**✔ [게시글 수정]**

![](https://velog.velcdn.com/images/da5105/post/07c62c96-67e5-44d4-b07f-199ccc4a8671/image.png)

**✔ [게시글 상세보기]**

(본인이 작성한 글이 아닐 경우)

![](https://velog.velcdn.com/images/da5105/post/bc255d3b-808b-42bc-bd5c-c3d4f5b28414/image.png)

(본인이 작성한 글일 경우)

![](https://velog.velcdn.com/images/da5105/post/3e3c9d6e-b5ec-4674-9a62-ed695045188f/image.png)

**✔ [댓글]**

(로그인 하기 전)

![](https://velog.velcdn.com/images/da5105/post/6312d8cb-be83-43c7-b72b-425247c67f55/image.png)

(로그인 한 후)
![](https://velog.velcdn.com/images/da5105/post/d365099d-b1d0-48d2-962b-5cea66c7e004/image.png)

- 게시글과 댓글 모두 로그인하지 않았다면 작성이 불가능
- 본인이 작성한 글, 댓글인 경우 수정과 삭제가 가능

### 문의사항 페이지
**✔ [초기상태]**

![](https://velog.velcdn.com/images/da5105/post/4fda14cd-1175-4247-bc64-67497a98a365/image.png)

**✔ ['문의하기' 버튼 클릭 시]**

![](https://velog.velcdn.com/images/da5105/post/e0dcce3d-7e1f-452f-8d43-4a8cb0275a98/image.png)

- 관리자에게 문의사항을 이메일로 보낼 수 있는 페이지
  -  ‘문의하기’ 클릭 시 알람창으로 이메일을 보냈다고 알려준다.

---

## 📑 KLC 환경설정 가이드 북

![](https://velog.velcdn.com/images/da5105/post/1c72251a-a4d8-4224-a4ec-32fff92e351b/image.png)
![](https://velog.velcdn.com/images/da5105/post/89a693f0-54b2-4bf1-80c7-8d9f76ae51ea/image.png)
![](https://velog.velcdn.com/images/da5105/post/e703f275-3b4f-4023-ac92-72706f3fd12c/image.png)
![](https://velog.velcdn.com/images/da5105/post/778ca801-967d-4569-9b9e-95d3f5a5f214/image.png)
![](https://velog.velcdn.com/images/da5105/post/fce168a8-b2b1-47d5-becf-6fe50c495ac5/image.png)
![](https://velog.velcdn.com/images/da5105/post/62db2d46-f9ab-41d6-ae8f-ceb85cc3992a/image.png)