package com.board.individual.mapper;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Param;

import com.board.individual.vo.IndividualVo;

@Mapper
public interface IndividualMapper {

	IndividualVo login(String user_id, String password);
	
	IndividualVo emailDupCheck(String email);

	IndividualVo getUserById(String user_id);

    List<IndividualVo> getappList(IndividualVo vo, @Param("user_id") String user_id,@Param("start") int start, @Param("size") int size);
	
	List<IndividualVo> getreList(IndividualVo vo, @Param("user_id") String user_id,@Param("start") int start, @Param("size") int size);
	
	
	int getReListCount(@Param("user_id") String user_id);

	int getAppListCount(@Param("user_id") String user_id);	

	void update(IndividualVo individualVo);

	void delete(IndividualVo individualVo);
	
    // 회원가입 처리 메서드
    void signup(IndividualVo individualVo);

	IndividualVo idDupCheck(String user_id);

	List<IndividualVo> recommendList(@Param("user_id") String user_id, @Param("start") int start, @Param("size") int size);

	int getTotalRecommend(String user_id);
	
	List<IndividualVo> ScrapList(@Param("user_id") String user_id, @Param("start") int start, @Param("size") int size);
	
	void insert(IndividualVo individualVo);
	
	List<IndividualVo> getappList(IndividualVo vo);
	
	List<String> getTitlesByUSerId(String user_id);

	void insert2(IndividualVo individualVo);

	IndividualVo getResum(String userid);

	List<IndividualVo> getreList(IndividualVo vo);

	IndividualVo getresumeList(IndividualVo individualVo);

	void update2(IndividualVo individualVo);

	void deleteres(IndividualVo individualVo);

	void delapplist(IndividualVo individualVo);

	void delbookmark(IndividualVo individualVo);


	List<IndividualVo> getsubres(String user_id, String title);

	List<IndividualVo> checkappex(String user_id, String aplnum);

	List<IndividualVo> checkTitleExists( String userId, String title);

	List<IndividualVo> getBookmarksByUsername(@Param("vo") IndividualVo vo, @Param("start") int start, @Param("size") int size);
	
	int getBookmarksCount(@Param("vo") IndividualVo vo	);

	IndividualVo getallUserById(String user_id);

	List<IndividualVo> getJobPostingsByUserId(String string);

	String checkdupmes(Map<String, Object> resultMap);

	void sendAIMassege(Map<String, Object> resultMap);

	String IsOnScrap(String user_id, String companyId, String compname);

	IndividualVo getCUserById(Map<String, Object> resultMap);

	void sendPostappMassege2(Map<String, Object> resultMap);

	void sendPostappMassege(Map<String, Object> resultMap);

	List<IndividualVo> ScrapList(String user_id);

	String getalpnum(String compname, String postId, String dateonly);

	List<IndividualVo> getMessages(String user_id);

	List<IndividualVo> getScrap(Map<String, Object> scrapMap);

	String IsScrap(Map<String, Object> scrapMap);

	void toggleScrap(Map<String, Object> scrapMap);

	void saveScrap(Map<String, Object> scrapMap);

	int checkIndividualUser(String user_id);

}
