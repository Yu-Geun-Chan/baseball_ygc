package com.baseball.controller;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class ImagesController {

    @GetMapping("/logo")
    public ResponseEntity<Resource> getImage() {
        try {
            // 로컬 컴퓨터의 이미지 경로를 설정합니다.
            Path imagePath = Paths.get("C:/work_YGC/logo/logo.png");  // 예시 경로
            Resource imageResource = new UrlResource(imagePath.toUri());

            // 이미지 파일이 존재하는지 확인합니다.
            if (!imageResource.exists() || !imageResource.isReadable()) {
                throw new RuntimeException("이미지를 찾을 수 없거나 읽을 수 없습니다.");
            }

            // 이미지 파일을 반환합니다.
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + imagePath.getFileName().toString() + "\"")
                    .body(imageResource);

        } catch (Exception e) {
            // 오류가 발생했을 경우 처리
            return ResponseEntity.badRequest().build();
        }
    }
}

