package com.baseball.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baseball.repository.PlayerRepository;
import com.baseball.vo.Player;

@Service
public class PlayerService {

	@Autowired
	private PlayerRepository playerRepository;

	public void savePlayer(Player player) {
		playerRepository.insertPlayer(player.getNumber(), player.getName(), player.getTeamName(), player.getHeight(),
				player.getWeight(), player.getPosition(), player.getBirthDate(), player.getProfileImage(),
				player.getCareer());
	}
}
