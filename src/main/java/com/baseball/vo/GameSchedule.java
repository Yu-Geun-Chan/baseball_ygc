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
    private String game;     // 경기
    private String location;  // 경기 장소
    private String etc;  // 비고

}
