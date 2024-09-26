<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="GAMESCHEDULE"></c:set>
<link rel="stylesheet" href="/resource/gameSchedule.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>

<h1 style="margin-right: 0; margin-left: 0; margin-top: 270px;">경기 일정 조회</h1>
<label style="margin-right: 0; margin-left: 0; margin-top: 300px;" for="month">월 선택:</label>
    <select id="month" name="month">
        <option value="01">1월</option>
        <option value="02">2월</option>
        <option value="03">3월</option>
        <option value="04">4월</option>
        <option value="05">5월</option>
        <option value="06">6월</option>
        <option value="07">7월</option>
        <option value="08">8월</option>
        <option value="09">9월</option>
        <option value="10">10월</option>
        <option value="11">11월</option>
        <option value="12">12월</option>
    </select>
    <button id="fetchSchedule">조회</button>

    <h2>경기 일정</h2>
    <table id="scheduleTable" border="1">
        <thead>
            <tr>
                <th>날짜</th>
                <th>시간</th>
                <th>팀 1</th>
                <th>경기 상태</th>
                <th>팀 2</th>
                <th>경기 장소</th>
            </tr>
        </thead>
        <tbody>
            <!-- 일정 데이터가 여기에 추가됩니다. -->
        </tbody>
    </table>

 <script>
        $(document).ready(function() {
            $("#fetchSchedule").click(function() {
                var month = $("#month").val();
                $.ajax({
                    url: "${pageContext.request.contextPath}/getSchedule", // 컨텍스트 경로에 따라 수정
                    type: "GET",
                    data: { month: month },
                    success: function(data) {
                        // 테이블 내용을 초기화
                        $("#scheduleTable tbody").empty();
                        // 데이터로 테이블 업데이트
                        for (var i = 0; i < data.length; i++) {
                            var row = "<tr>" +
                                "<td>" + data[i][0] + "</td>" +
                                "<td>" + data[i][1] + "</td>" +
                                "<td>" + data[i][2] + "</td>" +
                                "<td>" + data[i][3] + "</td>" +
                                "<td>" + data[i][4] + "</td>" +
                                "<td>" + data[i][5] + "</td>" +
                                "</tr>";
                            $("#scheduleTable tbody").append(row);
                        }
                    },
                    error: function() {
                        alert("경기 일정 로드 실패.");
                    }
                });
            });
        });
</script>

<%@ include file="../common/foot.jspf"%>