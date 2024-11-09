package com.baseball.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.baseball.vo.Player;

@Mapper
public interface PlayerRepository {

	@Insert("INSERT INTO player (number, name, teamName, height, weight, position, birthDate, profileImage, career) "
			+ "VALUES (#{number}, #{name}, #{teamName}, #{height}, #{weight}, #{position}, #{birthDate}, #{profileImage}, #{career})")
	void insertPlayer(@Param("number") String string, @Param("name") String name, @Param("teamName") String teamName,
			@Param("height") int height, @Param("weight") int weight, @Param("position") String position,
			@Param("birthDate") String birthDate, @Param("profileImage") String profileImage,
			@Param("career") String career);

	@Select("""
			<script>
			 SELECT *
			 FROM player
			 WHERE 1
			 <if test="teamName != null and teamName != ''">
			     AND teamName = #{teamName}
			 </if>
			 <if test="position != null and position != ''">
			     AND position = #{position}
			 </if>
			 <if test="name != null and name != ''">
			     AND `name` LIKE CONCAT('%', #{name}, '%')
			 </if>
			  ORDER BY `name` ASC
			  <if test="limitFrom >= 0">
				LIMIT #{limitFrom}, #{limitTake}
			  </if>
			 </script>
			""")
	List<Player> getForPrintPlayers(int limitFrom, int limitTake, String teamName, String position, String name);

	@Select("""
			<script>
			SELECT COUNT(*)
			FROM player
			WHERE 1
			<if test="teamName != null and teamName != ''">
			     AND teamName = #{teamName}
			 </if>
			 <if test="position != null and position != ''">
			     AND position = #{position}
			 </if>
			 <if test="name != null and name != ''">
			     AND `name` LIKE CONCAT('%', #{name}, '%')
			 </if>
			 </script>
			""")
	int getPlayersCount(String teamName, String position, String name);

	@Select("""
			 SELECT `name`, teamName, position, profileImage
			 FROM player
			 WHERE name = #{name}
			""")
	Player findPlayerByName(String name);

	@Select("""
			SELECT * FROM player WHERE id = #{id}
			""")
	Player findById(int id);
	
    // 이름을 기준으로 선수 존재 여부 확인
    @Select("SELECT COUNT(*) FROM player WHERE name = #{name} AND teamName = #{teamName}")
    boolean isPlayerExist(String name, String teamName);

    // 새로운 선수 저장
    @Insert("INSERT INTO player (number, name, teamName, height, weight, position, birthDate, career) " +
            "VALUES (#{number}, #{name}, #{teamName}, #{height}, #{weight}, #{position}, #{birthDate}, #{career})")
    void save(Player player);

}