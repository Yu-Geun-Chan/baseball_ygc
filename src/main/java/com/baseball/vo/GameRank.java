package com.baseball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GameRank {

	private String rank;
	private String teamName;
	private String games;
	private String wins;
	private String losses;
	private String gamesBehind;

}
