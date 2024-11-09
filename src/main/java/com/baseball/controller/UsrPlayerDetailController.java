package com.baseball.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.baseball.service.PlayerService;
import com.baseball.vo.Player;

@Controller
public class UsrPlayerDetailController {
    
	@Autowired
	private PlayerService playerService;
	
    // 선수 상세 정보 페이지를 보여주는 메서드
    @RequestMapping("/usr/player/detail/{id}")
    public String showPlayerDetail(@PathVariable("id") int id, Model model) {
    	
    	Player findPlayer = playerService.getPlayerById(id);
    	
    	model.addAttribute("player", findPlayer);
    	
        return "/usr/player/detail"; // 선수 상세 정보 페이지 반환
    }
}