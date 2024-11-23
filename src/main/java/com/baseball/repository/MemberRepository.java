package com.baseball.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.baseball.vo.Member;


@Mapper
public interface MemberRepository {

	@Select("SELECT LAST_INSERT_ID();")
	public int getLastInsertId();

	@Insert("INSERT INTO `member` SET regDate = NOW(), updateDate = NOW(), loginId = #{loginId}, loginPw = #{loginPw}, `name` = #{name}, nickname = #{nickname}, cellphoneNum = #{cellphoneNum}, email = #{email}")
	public void doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);

	@Select("SELECT * FROM `member` WHERE id = #{id}")
	public Member getMemberById(int id);

	@Select("""
			SELECT *
			FROM `member`
			WHERE loginId = #{loginId}
			""")
	public Member getMemberByLoginId(String loginId);

	@Select("""
			SELECT *
			FROM `member`
			WHERE name = #{name}
			AND email = #{email}
			""")
	public Member getMemberByNameAndEmail(String name, String email);

	@Update("""
			<script>
				UPDATE `member`
				<set>
					<if test="loginPw != null">
						loginPw = #{loginPw},
					</if>
					<if test="name != null">
						name = #{name},
					</if>
					<if test="nickname != null">
						nickname = #{nickname},
					</if>
					<if test="cellphoneNum != null">
						cellphoneNum = #{cellphoneNum},
					</if>
					<if test="email != null">
						email = #{email},
					</if>
					updateDate = NOW()
				</set>
				WHERE id = #{loginedMemberId}
			</script>
			""")
	public void modify(int loginedMemberId, String loginPw, String name, String nickname, String cellphoneNum,
			String email);

	@Update("""
			<script>
				UPDATE `member`
				<set>
					<if test="name != null">
						name = #{name},
					</if>
					<if test="nickname != null">
						nickname = #{nickname},
					</if>
					<if test="cellphoneNum != null">
						cellphoneNum = #{cellphoneNum},
					</if>
					<if test="email != null">
						email = #{email},
					</if>
					updateDate = NOW()
				</set>
				WHERE id = #{loginedMemberId}
			</script>
			""")
	public void modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum, String email);

	@Select("""
			<script>
			SELECT COUNT(*) AS cnt
			FROM `member` AS M
			WHERE 1
			<if test="authLevel != 0">
				AND M.authLevel = #{authLevel}
			</if>
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'loginId'">
						AND M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordTypeCode == 'name'">
						AND M.name LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordTypeCode == 'nickname'">
						AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND (
							M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
							OR M.name LIKE CONCAT('%', #{searchKeyword}, '%')
							OR M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
							)
					</otherwise>
				</choose>
			</if>
			</script>
							""")
	int getMembersCount(String authLevel, String searchKeywordTypeCode, String searchKeyword);

	@Select("""
			<script>
			SELECT M.*
			FROM `member` AS M
			WHERE 1
			<if test="authLevel != 0">
				AND M.authLevel = #{authLevel}
			</if>
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'loginId'">
						AND M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordTypeCode == 'name'">
						AND M.name LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordTypeCode == 'nickname'">
						AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND (
							M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
							OR M.name LIKE CONCAT('%', #{searchKeyword}, '%')
							OR M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
							)
					</otherwise>
				</choose>
			</if>
			ORDER BY M.id DESC
				<if test="limitTake != -1">
					LIMIT #{limitStart}, #{limitTake}
				</if>
			</script>
							""")
	List<Member> getForPrintMembers(String authLevel, String searchKeywordTypeCode, String searchKeyword,
			int limitStart, int limitTake);

	@Select("""
			<script>
			UPDATE `member`
			<set>
				updateDate = NOW(),
				delStatus = 1,
				delDate = NOW(),
			</set>
			WHERE id = #{id}
			</script>
			""")
	void deleteMember(int id);
	
    @Update("""
            UPDATE `member`
            SET updateDate = NOW(),
               delStatus = 1,
               delDate = NOW(),
               deletePendingDate = DATE_ADD(NOW(), INTERVAL #{gracePeriodDays} DAY)
            WHERE id = #{memberId}
            """)
    // 회원이 직접 탈퇴처리(유예기간 7일)
    int doDeleteMember(int memberId, int gracePeriodDays);

    @Update("""
            UPDATE `member`
            SET updateDate = NOW(),
               delStatus = 0,
               delDate = NULL,
              deletePendingDate = NULL
          WHERE id = #{memberId} AND delStatus = 1 AND deletePendingDate > NOW()
            """)
    // 회원의 delStatus가 1이고, 완전 삭제 유예기간이 현재보다 나중인 경우
    int restoreMember(int memberId);

    @Update("""
            UPDATE `member`
            SET delStatus = 2, updateDate = NOW()
            WHERE delStatus = 1 AND deletePendingDate <= NOW()
            """)
    // 회원 탈퇴 유예 기간이 지나지 않은 경우엔 복구가 가능하게
    int markMembersAsUnrecoverable();
}
