package com.baseball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Player {
	
	private int id;
	private Integer number;
	private String name;
	private String teamName;
	private Integer height;
	private Integer weight;
	private String position;
	private String birthDate;
	private String profileImage;
	private String profileCardImage;
	private String career;
	
	// id, profileImage, profileCardImage 제외한 생성자
	public Player (Integer number, String name, String teamName, Integer height, Integer weight, String position, String birthDate, String career) {
		this.number = number;
		this.name = name;
		this.teamName = teamName;
		this.height = height;
		this.weight = weight;
		this.position = position;
		this.birthDate = birthDate;
		this.career = career;
	}
}
