package com.baseball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Player {
	
	private Integer number;
	private String name;
	private String teamName;
	private int height;
	private int weight;
	private String position;
	private String birthDate;
	private String profileImage;
	private String career;
}
