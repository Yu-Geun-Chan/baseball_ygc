<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<link rel="stylesheet" href="/resource/head.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>

<div class="main-title">
	<div class="main-title-content">선수 정보</div>
</div>

<div class="main-content">
	<section class="card-container">
		<!-- 선수 카드 -->
		<div class="card-container-left">
			<div class="card pika animated" id="player-card" style="background-image: url('${player.profileCardImage}');">
				<div class="front"></div>
			</div>
		</div>

		<!-- 선수 기록 -->
		<div class="card-container-right">
			<div class="player-stats">
        		<h2>${player.name}</h2>
        		<p><strong>생년월일 : </strong>${player.birthDate}</p>
        		<p><strong>팀 : </strong>${player.teamName}</p>
        		<p><strong>등번호 : </strong>${player.number}</p>
        		<p><strong>포지션 : </strong>${player.position}</p>
        		<p><strong>체격 : </strong>${player.height}cm / ${player.weight}kg</p>
        		<p><strong>출신교 : </strong>${player.career}</p>

				<!-- 추가적인 선수 기록들 테이블 형식 -->
				<h3>시즌기록</h3>
				<table class="player-additional-stats">
				<colgroup>
				<col width="75">
				<col width="75">
				<col width="75">
				<col width="75">
				<col width="75">
				<col width="75">
				<col width="75">
				<col width="75">
				<col width="100">
				</colgroup>
					<thead style="font-size:">
						<tr>
							<th>경기</th>
							<th>타수</th>
							<th>타율</th>
							<th>안타</th>
							<th>홈런</th>
							<th>타점</th>
							<th>볼넷</th>
							<th>도루</th>
							<th>OPS</th>
						</tr>
					</thead>
					<tbody style="text-align:center;">
						<tr>
							<td>${playerStat.gamesPlayed}</td>
							<td>${playerStat.atBat}</td>
							<!-- 값이 없으면 안나오게 삼항연산자로 처리 -->
							<td>${playerStat.battingAverage != null ? String.format("%.3f", playerStat.battingAverage) : ""}</td>
							<td>${playerStat.hit}</td>
							<td>${playerStat.homeRun}</td>
							<td>${playerStat.rbi}</td>
							<td>${playerStat.walk}</td>
							<td>${playerStat.stolenBase}</td>
							<!-- 값이 없으면 안나오게 삼항연산자로 처리 -->
							<td>${playerStat.ops != null ? String.format("%.3f", playerStat.ops) : ""}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</section>
</div>

<script>
  // 팀별 색상에 맞는 클래스 이름 설정
  const teamClassMap = {
    "LG": "LG",
    "두산": "두산",
    "키움": "키움",
    "NC": "NC",
    "SSG": "SSG",
    "한화": "한화",
    "롯데": "롯데",
    "삼성": "삼성",
    "KIA": "KIA",
    "KT": "KT"
  };

  const teamName = "${player.teamName}";  // 서버에서 가져오는 팀 이름
  const playerCard = document.getElementById("player-card");

  // 해당 팀에 맞는 클래스 추가
  if (teamClassMap[teamName]) {
    playerCard.classList.add(teamClassMap[teamName]);
  } else {
    playerCard.classList.add("LG"); // 기본값으로 LG 색상 사용
  }
</script>

<!-- 카드 이펙트 -->
<script>
var x;
var $cards = $(".card");
var $style = $(".hover");

$cards
  .on("mousemove touchmove", function(e) { 
    var pos = [e.offsetX, e.offsetY];
    e.preventDefault();
    if (e.type === "touchmove") {
      pos = [e.touches[0].clientX, e.touches[0].clientY];
    }
    var $card = $(this);
    var l = pos[0];
    var t = pos[1];
    var h = $card.height();
    var w = $card.width();
    var px = Math.abs(Math.floor(100 / w * l) - 100);
    var py = Math.abs(Math.floor(100 / h * t) - 100);
    var pa = (50 - px) + (50 - py);
    var lp = (50 + (px - 50) / 1.5);
    var tp = (50 + (py - 50) / 1.5);
    var px_spark = (50 + (px - 50) / 7);
    var py_spark = (50 + (py - 50) / 7);
    var p_opc = 20 + (Math.abs(pa) * 1.5);
    var ty = ((tp - 50) / 2) * -1;
    var tx = ((lp - 50) / 1.5) * .5;
    var grad_pos = `background-position: ${lp}% ${tp}%;`;
    var sprk_pos = `background-position: ${px_spark}% ${py_spark}%;`;
    var opc = `opacity: ${p_opc / 100};`;
    var tf = `transform: rotateX(${ty}deg) rotateY(${tx}deg)`;
    var style = `
      .card:hover:before { ${grad_pos} }
      .card:hover:after { ${sprk_pos} ${opc} }
    `;
    $cards.removeClass("active");
    $card.removeClass("animated");
    $card.attr("style", tf);
    $style.html(style);
    if (e.type === "touchmove") {
      return false; 
    }
    clearTimeout(x);
  }).on("mouseout touchend touchcancel", function() {
    var $card = $(this);
    $style.html("");
    $card.removeAttr("style");
    x = setTimeout(function() {
      $card.addClass("animated");
    }, 2500);
  });
</script>

<style>
.main-title {
	width: 160px;
	height: 40px;
	position: absolute;
	left: calc(50% - 80px);
	top: 183px;
	overflow: hidden;
}

.main-title-content {
	color: #000000;
	text-align: center;
	font-size: 32px;
	line-height: 18px;
	font-weight: 700;
	position: absolute;
	left: calc(50% - 80px);
	top: 0px;
	width: 160px;
	height: 40px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.card-container {
	display: flex;
	align-items: flex-start;
	justify-content: center;
	margin-top: 20px;
}

.card-container-left {
	flex: 1;
	margin-right: -30%; /* 카드와 선수 기록 사이의 간격 */
}

.card-container-right {
    padding: 20px;
    background-color: #f4f4f4;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 130px;
    width: 60vw;
    height: 30vw;
    display: flex;
    flex-direction: column; /* 세로 방향으로 정렬 */
    align-items: center; /* 수평 가운데 정렬 */
    justify-content: center; /* 수직 가운데 정렬 */
    overflow: hidden; /* 콘텐츠가 영역을 벗어나지 않도록 설정 */
}

.player-stats {
    width: 100%;  /* 전체 너비를 차지하도록 설정 */
    max-height: 100%; /* 내용이 너무 많으면 스크롤이 생기도록 설정 */
    overflow-y: auto; /* 세로 스크롤을 추가 */
    padding-right: 10px; /* 오른쪽에 약간의 패딩을 추가하여 스크롤바가 겹치지 않도록 설정 */
    margin-bottom: 20px; /* 내용과 테이블 간의 간격 */
}

table {
    width: 100%; /* 전체 너비를 차지하도록 설정 */
    table-layout: fixed; /* 테이블 셀 너비를 균등하게 분배 */
    border-collapse: collapse; /* 테이블의 경계선이 겹치지 않도록 설정 */
    text-align: center; /* 테이블 내용 가운데 정렬 */
}

:root {
	--color1: rgb(0, 231, 255);
	--color2: rgb(255, 0, 231);
	--back: url(https://cdn2.bulbagarden.net/upload/1/17/Cardback.jpg);
	--pika1: #54a29e;
	--pika2: #a79d66;
	--pikafront: url('${player.profileCardImage}');
}

.card {
	width: 30vw;
	height: 30vw;
	position: relative;
	overflow: hidden;
	margin-left: 5%;
	margin-top: 130px;
	z-index: 10;
	touch-action: none;
	border-radius: 5%/3.5%;
	box-shadow: -5px -5px 5px -5px var(--color1), 5px 5px 5px -5px
		var(--color2), 0 55px 35px -20px rgba(0, 0, 0, 0.5);
	transition: transform 0.5s ease, box-shadow 0.2s ease;
	background-color: #040712;
	background-image: var(--pikafront);
	background-size: cover;
	background-repeat: no-repeat;
	background-position: 50% 50%;
	transform-style: preserve-3d; /* 3D 회전 효과 */
}

/* 홀로그램 효과를 위한 가상 요소 추가 */
.card::after {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: linear-gradient(45deg, rgba(255, 0, 231, 0.4),
		rgba(0, 231, 255, 0.4), rgba(255, 255, 0, 0.4), rgba(0, 255, 0, 0.4));
	background-size: 200% 200%;
	animation: hologramAnimation 2s infinite linear;
	z-index: 5;
	pointer-events: none; /* 클릭 방지 */
	opacity: 0.7;
	border-radius: 5%/3.5%;
}

@keyframes hologramAnimation {
  0% {
    background-position: 200% 0%;
  }
  50% {
    background-position: 0% 100%;
  }
  100% {
    background-position: 200% 0%;
  }
}
.card .front, .card .back {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	backface-visibility: hidden; /* 카드 뒷면 숨기기 */
}

.card .front {
	background-image: url('${player.profileCardImage}');
	background-size: cover;
	background-position: center;
}

.card .back {
	background-color: #333;
	color: white;
	transform: rotateY(180deg); /* 카드 뒷면을 180도 회전 */
	padding: 20px;
	box-sizing: border-box;
}

.card:hover {
	transform: rotateY(180deg); /* 카드 hover 시 180도 회전 */
}

.card:hover {
	box-shadow: -20px -20px 30px -25px var(--color1), 20px 20px 30px -25px
		var(--color2), 0 0 13px 4px rgba(255, 255, 255, 0.3), 0 55px 35px
		-20px rgba(0, 0, 0, 0.5);
}

/* 팀별 카드 색상 */
.card.LG {
	background-color: #C30037;
}

.card.두산 {
	background-color: #0E0E2A;
}

.card.키움 {
	background-color: #85001F;
}

.card.NC {
	background-color: #1F468F;
}

.card.SSG {
	background-color: #CD142C;
}

.card.한화 {
	background-color: #EF8A2F;
}

.card.롯데 {
	background-color: #D31F40;
}

.card.삼성 {
	background-color: #0064B2;
}

.card.KIA {
	background-color: #E20D28;
}

.card.KT {
	background-color: #000000;
}
</style>

<%@ include file="../common/foot.jspf"%>
