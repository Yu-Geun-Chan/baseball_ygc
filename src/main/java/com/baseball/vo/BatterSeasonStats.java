package com.baseball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BatterSeasonStats {

	int id;
	int playerId;
	String teamName;
	int seasonYear;
	int gamesPlayed;
	int atBat;
	float battingAverage;
	int hit;
	int homeRun;
	int rbi;
	int walk;
	int stolenBase;
	float ops;

	// id 제외한 생성자
	public BatterSeasonStats(int playerId, String teamName, int seasonYear, int gamesPlayed, int atBat,
			float battingAverage, int hit, int homeRun, int rbi, int walk, int stolenBase, float ops) {
		this.playerId = playerId;
		this.teamName = teamName;
		this.seasonYear = seasonYear;
		this.gamesPlayed = gamesPlayed;
		this.atBat = atBat;
		this.battingAverage = battingAverage;
		this.hit = hit;
		this.rbi = rbi;
		this.rbi = rbi;
		this.stolenBase = stolenBase;
		this.ops = ops;
	}
}
