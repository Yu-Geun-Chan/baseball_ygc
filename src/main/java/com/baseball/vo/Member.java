package com.baseball.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {

	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private int authLevel;
	private String name;
	private String nickname;
	private String cellphoneNum;
	private String email;
	private String profileImage;
	private int delStatus;
	private String delDate;
	 private LocalDateTime deletePendingDate;

	// 응원 선수
	private int	favoritePlayerId;
	private String messageToPlayer;
	
	public String getForPrintType1RegDate() {
		return regDate.substring(2, 16).replace(" ", "<br />");
	}

	public String getForPrintType1UpdateDate() {
		return updateDate.substring(2, 16).replace(" ", "<br />");
	}

}