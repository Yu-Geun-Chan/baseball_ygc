DROP DATABASE IF EXISTS ygc_Spring;
CREATE DATABASE ygc_Spring;
USE ygc_Spring;

-- Table 추가
CREATE TABLE `member` (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	loginId	CHAR(100) UNIQUE	NOT NULL,
	loginPw	CHAR(200)	NOT NULL,
	`name` CHAR(100)	NOT NULL,
	nickname	CHAR(100)	NOT NULL,
	regDate	DATETIME	NOT NULL,
	updateDate	DATETIME	NOT NULL,
	cellPhoneNum	CHAR(20)	NOT NULL,
	email	CHAR(50)	NOT NULL,
	profileImage	VARCHAR(255)	NULL,
	favoritePlayerId	INT(10) UNSIGNED NULL,
	messageToPlayer	TEXT	NULL,
	authLevel	SMALLINT(2) UNSIGNED	NOT NULL	DEFAULT 3	COMMENT '권한 (관리자 = 7, 일반유저 = 3)',
	delStatus	TINYINT(1) UNSIGNED	NOT NULL	DEFAULT 0	COMMENT '탈퇴 여부 (탈퇴 전 =  0, 탈퇴 후 = 1)',
	delDate	DATETIME	NULL	COMMENT '탈퇴 날짜'
);

CREATE TABLE player (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	`number`	INTEGER(5)	NULL DEFAULT NULL,
	`name`	CHAR(100) NOT NULL,
	teamName	CHAR(100) NOT NULL,
	`position`	CHAR(10)	NOT NULL,
	birthDate	CHAR(20)	NOT NULL,
	height	INTEGER(5)	NULL DEFAULT NULL,
	weight	INTEGER(5)	NULL DEFAULT NULL,
	profileImage	VARCHAR(255)	NULL	COMMENT 'NULL 허용 사진 없는 경우도 있기 때문에',
	career	VARCHAR(255)	NOT NULL
);
ALTER TABLE player 
ADD COLUMN profileCardImage VARCHAR(255) NULL COMMENT 'NULL 허용 사진 없는 경우도 있기 때문에' 
AFTER profileImage;

CREATE TABLE memberProfileImage (
	id INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY, 
	memberId INT(10) UNSIGNED	NOT NULL,
	imagePath VARCHAR(255)	NOT NULL,
	regDate	DATETIME	NULL,
	updateDate	DATETIME	NULL
);

CREATE TABLE playerProfileImage (
	id INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	playerId INT(10) UNSIGNED NOT NULL,
	imagePath VARCHAR(255) NOT NULL,
	regDate	DATETIME NULL,
	updateDate DATETIME	NULL
);

CREATE TABLE team (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	`name`	CHAR(20)	NOT NULL
);

CREATE TABLE stadiumImage (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	stadiumId	INT(10) UNSIGNED	NOT NULL,
	imagePath	VARCHAR(255)	NOT NULL,
	regDate	DATETIME	NULL,
	updateDate	DATETIME	NULL
);

CREATE TABLE stadium (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	teamId	INT(10) UNSIGNED	NOT NULL,
	`name`	CHAR(20)	NOT NULL,
	address CHAR(100)	NOT NULL,
	image	VARCHAR(255)	NULL
);

CREATE TABLE logoType (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	teamId	INT(10) UNSIGNED NOT NULL,
	image	VARCHAR(255)	NULL
);

CREATE TABLE logoTypeImage (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	logoTypeId	INT(10) UNSIGNED	NOT NULL,
	imagePath	VARCHAR(255)	NOT NULL,
	regDate	DATETIME	NULL,
	updateDate	DATETIME	NULL
);

CREATE TABLE game (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	gameStadiumName	CHAR(20)	NOT NULL,
	gameStartDate	DATETIME	NOT NULL,
	gameResult	CHAR(50)	NOT NULL,
	homeTeamScore	INT	NOT NULL	DEFAULT 0,
	awayTeamScore	INT	NOT NULL	DEFAULT 0,
	homeTeamId INT(10) UNSIGNED	NOT NULL,
	awayTeamId INT(10) UNSIGNED	NOT NULL
);

CREATE TABLE atBat (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	gameId	INT(10) UNSIGNED	NOT NULL,
	inning	INT	NOT NULL,
	result	DATETIME	NOT NULL	COMMENT '삼진, 땅볼, 플라이아웃, 안타, 홈런, 실책, 다른사유 등',
	rbi	INT	NOT NULL	DEFAULT 0,
	run	INT	NOT NULL	DEFAULT 0,
	batterId INT(10) UNSIGNED	NOT NULL,
	pitcherId INT(10) UNSIGNED	NOT NULL
);

CREATE TABLE article (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	memberId INT(10) UNSIGNED NOT NULL,
	boardId INT(10) UNSIGNED NOT NULL,
	title	CHAR(100)	NOT NULL,
	`body`	TEXT	NOT NULL,
	regDate	DATETIME	NOT NULL,
	updateDate	DATETIME	NOT NULL,
	hitCount	INT(10) UNSIGNED	NOT NULL	DEFAULT 0,
	goodReactionPoint	INT(10) UNSIGNED	NOT NULL	DEFAULT 0,
	badReactionPoint	INT(10) UNSIGNED	NOT NULL	DEFAULT 0
);

CREATE TABLE reply (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	memberId	INT(10) UNSIGNED	NOT NULL,
	relTypeCode	CHAR(50)	NOT NULL,
	relId	INT(10)	NOT NULL,
	`body`	TEXT	NOT NULL,
	regDate	DATETIME	NOT NULL,
	updateDate	DATETIME	NOT NULL,
	goodReactionPoint	INT(10) UNSIGNED	NOT NULL	DEFAULT 0,
	badReactionPoint	INT(10) UNSIGNED	NULL	DEFAULT 0
);

CREATE TABLE reactionPoint (
    id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	memberId	INT(10) UNSIGNED	NOT NULL,
	relTypeCode	CHAR(50)	NOT NULL,
	relId	INT(10)	NOT NULL,
	`body`	TEXT	NOT NULL,
	regDate	DATETIME	NOT NULL,
	updateDate	DATETIME	NOT NULL,
	`point`	INT(10)	NOT NULL
);

CREATE TABLE board (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	regDate	DATETIME	NOT NULL,
	updateDate	DATETIME	NOT NULL,
	`code`	CHAR(50) UNIQUE	NOT NULL	COMMENT 'notice(공지사항) free(자유게시판)...',
	`name`	CHAR(20) UNIQUE	NOT NULL	COMMENT '게시판 이름',
	delStatus	TINYINT(1) UNSIGNED	NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
	delDate	DATETIME COMMENT '삭제 날짜'
);

ALTER TABLE board MODIFY COLUMN delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)';

CREATE TABLE BatterSeasonStats (
	id	INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
	playerId	INT(10) UNSIGNED NOT NULL,
	teamName	VARCHAR(50)	NOT NULL,
	seasonYear	INT(10) UNSIGNED,
	gamesPlayed	INT(10) UNSIGNED,
	pa	INT(10) UNSIGNED,
	atBat	INT(10) UNSIGNED,
	run	INT(10) UNSIGNED,
	hit	INT(10) UNSIGNED,
	`double` INT(10) UNSIGNED,
	triple	INT(10) UNSIGNED,
	homeRun	INT(10) UNSIGNED,
	rbi	INT(10) UNSIGNED,
	stolenBase	INT(10) UNSIGNED,
	caughtStealing	INT(10) UNSIGNED,
	walk	INT(10) UNSIGNED,
	strikeout	INT(10) UNSIGNED,
	hitByPitch	INT(10) UNSIGNED,
	sacrificeFly INT(10) UNSIGNED,
	battingAverage	FLOAT UNSIGNED,
	onBasePercentage	FLOAT UNSIGNED,
	sluggingPercentage	FLOAT UNSIGNED,
	ops	FLOAT UNSIGNED	NOT NULL,
	doublePlay	INT(10) UNSIGNED,
	`error`	INT(10) UNSIGNED
);

CREATE TABLE PitcherSeasonStats (
	id	INT UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY, 
	playerId	INT(10) UNSIGNED	NOT NULL,
	teamName	VARCHAR(50)	NOT NULL,
	seasonYear	INT(10),
    win	INT(10) UNSIGNED,
	lose INT(10) UNSIGNED,
	era	FLOAT UNSIGNED,
	gamesPlayed	INT(10),
	completeGame INT(10) UNSIGNED,
	shutout	INT(10) UNSIGNED,
	save	INT(10) UNSIGNED,
	hold	INT(10) UNSIGNED,
	inning	FLOAT UNSIGNED,
	hitAllowed	INT(10) UNSIGNED,
	doubleAllowed	INT(10) UNSIGNED,
	tripleAllowed	INT(10) UNSIGNED,
	homeRunAllowed	INT(10) UNSIGNED,
	runAllowed	INT(10) UNSIGNED,
	earnedRun	INT(10) UNSIGNED,
	walk	INT(10) UNSIGNED,
	strikeout	INT(10) UNSIGNED,
	whip	FLOAT UNSIGNED,
	hitByPitch	INT(10) UNSIGNED,
	balk	INT(10) UNSIGNED,
	wildPitch	INT(10) UNSIGNED,
	battersFaced INT(10) UNSIGNED
);

CREATE TABLE TeamSeasonStats (
	id	INT(10) UNSIGNED AUTO_INCREMENT	NOT NULL PRIMARY KEY,
	teamId	INT(10) UNSIGNED	NOT NULL,
	teamName	VARCHAR(50)	NOT NULL,
	seasonYear	INT(10) UNSIGNED,
	win	INT(10) UNSIGNED,
	lose	INT(10) UNSIGNED,
	draw	INT(10) UNSIGNED,
	runsScored	INT(10) UNSIGNED,
	runsAllowed	INT(10) UNSIGNED,
	homeRun	INT(10) UNSIGNED,
	stolenBase	INT(10) UNSIGNED,
	`error`	INT(10) UNSIGNED
);

-- 여기까지 Table 추가

############### INIT 시작
## 테스트 데이터 생성

## 게시글 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목4',
`body` = '내용4';

## 회원 테스트 데이터 생성
## (관리자)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
nickname = '관리자',
cellphoneNum = '01012341234',
email = 'abc@gmail.com';

## (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1_이름',
nickname = '회원1_닉네임',
cellphoneNum = '01043214321',
email = 'axdswww12@gmail.com';

## (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2_이름',
nickname = '회원2_닉네임',
cellphoneNum = '01056785678',
email = 'abcde@gmail.com';

UPDATE article
SET memberId = 2
WHERE id IN (1,2);

UPDATE article
SET memberId = 3
WHERE id IN (3,4);

## 게시판(board) 테스트 데이터 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'NOTICE',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'FREE',
`name` = '자유게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'QnA',
`name` = '질의응답';

UPDATE article
SET boardId = 1
WHERE id IN (1,2);

UPDATE article
SET boardId = 2
WHERE id = 3;

UPDATE article
SET boardId = 3
WHERE id = 4;

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 1번 회원이 2번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

# 2번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 2번 회원이 2번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`point` = -1;

# 3번 회원이 1번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

# update join -> 기존 게시글의 good bad RP 값을 RP 테이블에서 추출해서 article table에 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode, Rp.relId,
    SUM(IF(RP.point > 0,RP.point,0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0,RP.point * -1,0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode,Rp.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 1';

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 2';

# 3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 3';

# 3번 회원이 2번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 4';

# 3번 회원이 3번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 3,
`body` = '댓글 5';

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 1번 회원이 2번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 2,
`point` = 1;

# 2번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 2번 회원이 2번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 2,
`point` = -1;

# 3번 회원이 1번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'reply',
relId = 1,
`point` = 1;

# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE reply AS R
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON R.id = RP_SUM.relId
SET R.goodReactionPoint = RP_SUM.goodReactionPoint,
R.badReactionPoint = RP_SUM.badReactionPoint;

# 기존의 회원 비번을 암호화
UPDATE `member`
SET loginPw = SHA2(loginPw,256);

######## init 끝

-- FOREIGN KEY 추가
ALTER TABLE memberProfileImage ADD CONSTRAINT FK_memberProfileImage_member FOREIGN KEY (memberId) REFERENCES `member`(id)
ON DELETE CASCADE;

ALTER TABLE playerProfileImage ADD CONSTRAINT FK_playerProfileImage_player FOREIGN KEY (playerId) REFERENCES player(id)
ON DELETE CASCADE;

ALTER TABLE stadiumImage ADD CONSTRAINT FK_stadiumImage_stadium FOREIGN KEY (stadiumId) REFERENCES stadium(id)
ON DELETE CASCADE;

ALTER TABLE stadium ADD CONSTRAINT FK_stadium_team FOREIGN KEY (teamId) REFERENCES team(id)
ON DELETE CASCADE;

ALTER TABLE logoType ADD CONSTRAINT FK_logoType_team FOREIGN KEY (teamId) REFERENCES team(id)
ON DELETE CASCADE;

ALTER TABLE logoTypeImage ADD CONSTRAINT FK_logoTypeImage_logoType FOREIGN KEY (logoTypeId) REFERENCES logoType(id)
ON DELETE CASCADE;

ALTER TABLE game ADD CONSTRAINT FK_game_homeTeam FOREIGN KEY (homeTeamId) REFERENCES team(id)
ON DELETE CASCADE;

ALTER TABLE game ADD CONSTRAINT FK_game_awayTeam FOREIGN KEY (awayTeamId) REFERENCES team(id)
ON DELETE CASCADE;

ALTER TABLE atBat ADD CONSTRAINT FK_atBat_game FOREIGN KEY (gameId) REFERENCES game(id)
ON DELETE CASCADE;

ALTER TABLE atBat ADD CONSTRAINT FK_atBat_batter FOREIGN KEY (batterId) REFERENCES player(id)
ON DELETE CASCADE;

ALTER TABLE atBat ADD CONSTRAINT FK_atBat_pitcher FOREIGN KEY (pitcherId) REFERENCES player(id)
ON DELETE CASCADE;

ALTER TABLE article ADD CONSTRAINT FK_article_member FOREIGN KEY (memberId) REFERENCES `member`(id)
ON DELETE CASCADE;

ALTER TABLE reply ADD CONSTRAINT FK_reply_member FOREIGN KEY (memberId) REFERENCES `member`(id)
ON DELETE CASCADE;

ALTER TABLE reactionPoint ADD CONSTRAINT FK_reactionPoint_member FOREIGN KEY (memberId) REFERENCES `member`(id)
ON DELETE CASCADE;

ALTER TABLE BatterSeasonStats ADD CONSTRAINT FK_BatterSeasonStats_player FOREIGN KEY (playerId) REFERENCES player(id)
ON DELETE CASCADE;

ALTER TABLE PitcherSeasonStats ADD CONSTRAINT FK_PitcherSeasonStats_player FOREIGN KEY (playerId) REFERENCES player(id)
ON DELETE CASCADE;

ALTER TABLE TeamSeasonStats ADD CONSTRAINT FK_TeamSeasonStats_team FOREIGN KEY (teamId) REFERENCES team(id)
ON DELETE CASCADE;
-- 여기까지 외래키 추가

# player 테이블 number 칼럼 'null'을 NULL로 치환
UPDATE player SET `number` = NULL WHERE `number` = 'null';
UPDATE player SET `height` = NULL WHERE `height` = 'null';
UPDATE player SET `weight` = NULL WHERE `weight` = 'null';

# 각 구단별 대표선수 프로필사진, 선수정보 사진 테스트
UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/662.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/662.png'
WHERE `name` = '노시환';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/100.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/100.png'
WHERE `name` = '김도영';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/25.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/25.png'
WHERE `name` = '김현수';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/185.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/185.png'
WHERE `name` = '구자욱';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/418.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/418.png'
WHERE `name` = '양의지';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/271.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/271.png'
WHERE `name` = '강백호';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/538.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/538.png'
WHERE `name` = '최정';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/614.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/614.png'
WHERE `name` = '전준우';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/788.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/788.png'
WHERE `name` = '손아섭';

UPDATE player
SET profileImage = 'http://localhost:8083/images/playerImages/874.png',
profileCardImage = 'http://localhost:8083/images/playerCardImages/874.png'
WHERE `name` = '송성문';
# 여기까지 선수 사진 데이터

SELECT * FROM `member`;

SELECT * FROM player;

SELECT * FROM player
WHERE `name` = '김도영';

SELECT * FROM player
WHERE `name` = '노시환';

SELECT * FROM player
WHERE teamName = 'KIA';

DROP TABLE player;

SELECT * FROM board;

SELECT * FROM article;

SELECT * FROM reply;

SELECT * FROM article AS A
INNER JOIN reply AS R
ON R.relId = A.id
WHERE A.id = 3;
 
SELECT COUNT(*) FROM player WHERE `position` = '포수';

SELECT COUNT(*) FROM player WHERE teamName = '고양';
SHOW GLOBAL VARIABLES LIKE 'local_infile';