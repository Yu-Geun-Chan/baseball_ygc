package com.baseball.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baseball.repository.PlayerRepository;
import com.baseball.vo.Player;

@Service
public class PlayerService {

	@Autowired
	private PlayerRepository playerRepository;

//	public void savePlayer(Player player) {
//		playerRepository.insertPlayer(player.getNumber(), player.getName(), player.getTeamName(), player.getHeight(),
//				player.getWeight(), player.getPosition(), player.getBirthDate(), player.getProfileImage(),
//				player.getCareer());
//	}

	public List<Player> getForPrintPlayers(int itemsInAPage, int page, String teamName, String position, String name) {
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return playerRepository.getForPrintPlayers(limitFrom, limitTake, teamName, position, name);
	}

	public int getPlayersCount(String teamName, String position, String name) {
		return playerRepository.getPlayersCount(teamName, position, name);
	}

	public Player findPlayerByName(String name) {
		return playerRepository.findPlayerByName(name);
	}
	
    public Player getPlayerById(int id) {
        return playerRepository.findById(id); 
    }
    
    // 선수가 없을 경우에만 저장하는 메서드
    @Transactional
    public void saveIfNotExist(Player player) {
        if (!playerRepository.isPlayerExist(player.getName(), player.getTeamName())) {
            playerRepository.save(player);
        }
    }

}
