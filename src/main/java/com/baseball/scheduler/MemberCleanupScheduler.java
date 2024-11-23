package com.baseball.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.baseball.service.MemberService;

@Component
public class MemberCleanupScheduler {
    private final MemberService memberService;
    public MemberCleanupScheduler(MemberService memberService) {
        this.memberService = memberService;
    }
    @Scheduled(cron = "0 0 0 * * *") // 매일 자정 실행
    public void processExpiredMembers() {
        int deletedCount = memberService.deleteExpiredMembers();
        System.out.println("유예 기간이 만료된 계정 " + deletedCount + "건 삭제 완료");
    }
}
