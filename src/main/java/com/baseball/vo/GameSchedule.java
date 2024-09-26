package com.baseball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GameSchedule {

	private String gameDay;       // 경기 날짜
    private String time;      // 경기 시간
    private String team1;     // 첫 번째 팀
    private String vs;        // 경기 상태 (vs)
    private String team2;     // 두 번째 팀
    private String location;  // 경기 장소

}
