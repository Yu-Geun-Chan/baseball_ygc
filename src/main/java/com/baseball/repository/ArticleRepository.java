package com.baseball.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.baseball.vo.Article;

@Mapper
public interface ArticleRepository {

	@Insert("""
			INSERT INTO article
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			boardId = #{boardId},
			title = #{title},
			`body` = #{body}
			""")
	public void writeArticle(int memberId, String title, String body, String boardId);

	@Delete("""
			DELETE FROM article
			WHERE id = #{id}
			""")
	public void deleteArticle(int id);

	@Update("""
			UPDATE article
			SET updateDate = NOW(),
			title = #{title},
			`body` = #{body}
			WHERE id = #{id}
			""")
	public void modifyArticle(int id, String title, String body);

	@Select("""
			SELECT A.*, M.nickname AS extra__writer
			FROM article AS A
			INNER JOIN `member` AS M
			ON A.memberId = M.id
			WHERE A.id = #{id}
				""")
	public Article getForPrintArticle(int id);

	@Select("""
			SELECT *
			FROM article
			WHERE id = #{id}
				""")
	public Article getArticleById(int id);

	@Select("""
			<script>
				SELECT A.*, M.nickname AS extra__writer, IFNULL(COUNT(R.id),0) AS extra__repliesCount
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				LEFT JOIN `reply` AS R
				ON A.id = R.relId
				WHERE 1
				<if test="boardId != 0">
					AND boardId = #{boardId}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordTypeCode == 'title'">
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'body'">
							AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'writer'">
							AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</otherwise>
					</choose>
				</if>
				GROUP BY A.id
				ORDER BY A.id DESC
				<if test="limitFrom >= 0">
					LIMIT #{limitFrom}, #{limitTake}
				</if>
				</script>
			""")
	public List<Article> getForPrintArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode,
			String searchKeyword);

	@Select("""
			<script>
				SELECT COUNT(*), A.*, M.nickname AS extra__writer
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				WHERE 1
				<if test="boardId != 0">
					AND A.boardId = #{boardId}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordTypeCode == 'title'">
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'body'">
							AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'writer'">
							AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</otherwise>
					</choose>
				</if>
				ORDER BY A.id DESC;
			</script>
			""")
	public int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword);
	
    @Select("SELECT * FROM article WHERE memberId = #{memberId}")
    public List<Article> getArticlesById(int memberId);

	@Select("""
			<script>
			    SELECT A.*, M.nickname AS extra__writer
			    FROM article AS A
			    INNER JOIN `member` AS M
			    ON A.memberId = M.id
			    WHERE A.memberId = #{userId}
			    <if test="boardId != 0">
			        AND A.boardId = #{boardId}
			    </if>
			    <if test="searchKeyword != ''">
			        <choose>
			            <when test="searchKeywordTypeCode == 'title'">
			                AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
			            </when>
			            <when test="searchKeywordTypeCode == 'body'">
			                AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
			            </when>
			            <when test="searchKeywordTypeCode == 'writer'">
			                AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
			            </when>
			            <otherwise>
			                AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
			                OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
			            </otherwise>
			        </choose>
			    </if>
			    ORDER BY A.id DESC
			    <if test="limitFrom >= 0">
			        LIMIT #{limitFrom}, #{limitTake}
			    </if>
			</script>
			""")
	List<Article> getForPrintArticlesByUser(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode,
			String searchKeyword, int userId);

	@Select("""
			<script>
			    SELECT COUNT(*)
			    FROM article AS A
			    WHERE A.memberId = #{userId}
			    <if test="boardId != 0">
			        AND A.boardId = #{boardId}
			    </if>
			    <if test="searchKeyword != ''">
			        <choose>
			            <when test="searchKeywordTypeCode == 'title'">
			                AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
			            </when>
			            <when test="searchKeywordTypeCode == 'body'">
			                AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
			            </when>
			            <when test="searchKeywordTypeCode == 'writer'">
			                AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
			            </when>
			            <otherwise>
			                AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
			                OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
			            </otherwise>
			        </choose>
			    </if>
			</script>
			""")
	int getArticlesCountByUser(int boardId, String searchKeywordTypeCode, String searchKeyword, int userId);

	@Select("""
			SELECT A.* , M.nickname AS extra__writer
			FROM article AS A
			INNER JOIN `member` AS M
			ON A.memberId = M.id
			ORDER BY A.id DESC
			""")
	public List<Article> getArticles();

	@Select("SELECT LAST_INSERT_ID();")
	public int getLastInsertId();

	@Select("""
			SELECT hitCount
			FROM article
			WHERE id = #{id}
				""")
	public int getArticleHitCount(int id);

	@Update("""
			UPDATE article
			SET goodReactionPoint = goodReactionPoint + 1
			WHERE id = #{relId}
			""")
	public int increaseGoodReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET goodReactionPoint = goodReactionPoint - 1
			WHERE id = #{relId}
			""")
	public int decreaseGoodReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET badReactionPoint = badReactionPoint + 1
			WHERE id = #{relId}
			""")
	public int increaseBadReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET badReactionPoint = badReactionPoint - 1
			WHERE id = #{relId}
			""")
	public int decreaseBadReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET hitCount = hitCount + 1
			WHERE id = #{id}
			""")
	public int increaseHitCount(int id);

	@Select("""
			SELECT goodReactionPoint
			FROM article
			WHERE id = #{relId}
			""")
	public int getGoodRP(int relId);

	@Select("""
			SELECT badReactionPoint
			FROM article
			WHERE id = #{relId}
			""")
	public int getBadRP(int relId);

	@Select("""
			SELECT MAX(id) + 1
			FROM article
			""")
	public int getCurrentArticleId();

	@Select("""
			SELECT COUNT(*) FROM article WHERE memberId = #{loginedMemberId}
			""")
	public Object getArticleCountByMemberId(Integer loginedMemberId);

}
