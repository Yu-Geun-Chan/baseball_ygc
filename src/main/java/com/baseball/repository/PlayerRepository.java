package com.baseball.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PlayerRepository {

    @Insert("INSERT INTO player (number, name, teamName, height, weight, position, birthDate, profileImage, career) " +
            "VALUES (#{number}, #{name}, #{teamName}, #{height}, #{weight}, #{position}, #{birthDate}, #{profileImage}, #{career})")
    void insertPlayer(
        @Param("number") int number,
        @Param("name") String name,
        @Param("teamName") String teamName,
        @Param("height") int height,
        @Param("weight") int weight,
        @Param("position") String position,
        @Param("birthDate") String birthDate,
        @Param("profileImage") String profileImage,
        @Param("career") String career
    );
}