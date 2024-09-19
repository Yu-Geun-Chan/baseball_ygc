package com.baseball.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baseball.service.PlayerService;
import com.baseball.vo.Player;

@Controller
public class UsrPlayerController {

	@Autowired
	private PlayerService playerService;

	@RequestMapping("/usr/player/players")
	public String showPlayers(Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(value = "teamName", defaultValue = "") String teamName,
			@RequestParam(value = "position", defaultValue = "") String position,
			@RequestParam(value = "name", defaultValue = "") String name) {

		int playersCount = playerService.getPlayersCount(teamName, position, name);

		// 한페이지에 글 10개
		// 글 20개 -> 2page
		// 글 25개 -> 3page
		int itemsInAPage = 10;

		int pagesCount = (int) Math.ceil(playersCount / (double) itemsInAPage);

		List<Player> players = playerService.getForPrintPlayers(itemsInAPage, page, teamName, position, name);

		model.addAttribute("players", players);
		model.addAttribute("playersCount", playersCount);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("teamName", teamName);
		model.addAttribute("page", page);
		model.addAttribute("position", position);
		model.addAttribute("name", name);

		return "/usr/player/players";
	}

	@GetMapping("/players")
	@ResponseBody
	public Map<String, Object> getPlayers(@RequestParam(defaultValue = "1") int page,
			@RequestParam(value = "teamName", defaultValue = "") String teamName,
			@RequestParam(value = "position", defaultValue = "") String position,
			@RequestParam(value = "name", defaultValue = "") String name) {

		int playersCount = playerService.getPlayersCount(teamName, position, name);

		// 한페이지에 글 10개
		int itemsInAPage = 10;
		int pagesCount = (int) Math.ceil(playersCount / (double) itemsInAPage);

		List<Player> players = playerService.getForPrintPlayers(itemsInAPage, page, teamName, position, name);

		Map<String, Object> response = new HashMap<>();
		response.put("players", players);
		response.put("playersCount", playersCount);
		response.put("totalPages", pagesCount);
		response.put("currentPage", page);

		return response;
	}
}