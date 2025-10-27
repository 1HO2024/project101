package com.board.company.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.board.company.vo.CompanyVo;
import com.board.individual.vo.IndividualVo;

@Mapper
public interface CompanyMapper {

	CompanyVo login(String user_id, String password);
	
	CompanyVo getUserById(String user_id);
    
    void update(CompanyVo companyVo);
    
    void delete(CompanyVo companyVo);

	void signup(CompanyVo companyVo);

	

	CompanyVo getmain(CompanyVo companyVo);
	
	CompanyVo getcomp(String compname);

	CompanyVo getuser(String userId);

	void plushit(CompanyVo companyVo);

	void insertposting(CompanyVo companyVo);

	void deleteposting(CompanyVo companyVo);

	void updateposting(CompanyVo companyVo);
	
	List<String> getPostIdsByUserId(			
			@Param("user_id") String user_id, 
			@Param("compname") String compname, 
			@Param("start") int start, 
			@Param("size") int size);
	
	int getResumeCount(@Param("compname") String compname);
	
	List<IndividualVo> getApplicationsByPostIds(List<String> postIds);
	
	List<IndividualVo> getResumeListByPostId(String string);

	IndividualVo getresumeList(IndividualVo individualVo);

	void companysignup(CompanyVo companyVo);

	CompanyVo idDupCheck(String user_id);

	CompanyVo compDupCheck(String compname);
	
	CompanyVo emailDupCheck(String email);

	void updateresume(String title, String result, String post_id);

	List<CompanyVo> getfaqList();

	List<CompanyVo> getcsList(
			@Param("user_id") String user_id,       
			@Param("start") int start, 							  
			@Param("size") int size);
	
	int getTotalCs();

	void insertcs(CompanyVo companyVo);

	void updatecs(CompanyVo companyVo);

	List<CompanyVo> recommendList(
			@Param("compname") String compname, 
			@Param("start") int start, 
			@Param("size") int size);
	
	int getTotalRecommend(
			@Param("user_id") String user_id, 
			@Param("compname") String compname);
	
	List<CompanyVo> getSortedPostList();

	String compnameByUserId(String user_id);

	List<CompanyVo> getCompanyList(
			@Param("compname") String compname, 
			@Param("start") int start, 
			@Param("size") int size);
	
	int getTotalCpost(String compname);

	void updateresume(IndividualVo vo);

	List<CompanyVo> getBookmark(String userId, String title, String compname);

	String isBookmark(String userId, String title);

	void toggleBookmark(String userId, String title);

	void saveBookmark(CompanyVo companyVo);

	List<CompanyVo> bookmarkList(
			@Param("user_id") String user_id, 
			@Param("title") String title, 
			@Param("start") int start, 
			@Param("size") int size);
	
	int getTotalBookmark(
			@Param("user_id") String user_id);
	
	//======================================================================
	List<CompanyVo> getnoPostList(
			@Param("start") int start,
			@Param("size") int size);
	
	List<CompanyVo> getmainPostList(
			@Param("start") int start,
			@Param("size") int size);
	
	List<CompanyVo> getrePostList(
	        @Param("start") int start,
	        @Param("size") int size,
	        @Param("sort") String sort);
	
	int getnoTotalPost();
	int getmainTotalPost();
	int getreTotalPost(); 

	//======================================================================
	List<IndividualVo> getappList();

	void deletecs(CompanyVo companyVo);

	int getTotalUsers();

	int getTotalCompUsers();

	int getTotalPost(); 

	CompanyVo getcs(String userId, String cspTitle);

	CompanyVo getcs(CompanyVo companyVo);

	List<CompanyVo> getpostlistSortfirsts(@Param("start") int start, @Param("size") int size);
	   
	List<CompanyVo> getpostlistSortLast(@Param("start") int start, @Param("size") int size);
	   
	List<CompanyVo> getpostlistSortCount(@Param("start") int start, @Param("size") int size);

	List<CompanyVo> getmainList(@Param("start") int start, @Param("size") int size);
	
	String checkdupmes(Map<String, Object> resultMap);

	void sendAIMassege(Map<String, Object> resultMap);

	List<CompanyVo> getApplicationformessage(String post_id);

	void sendresumeresultMassege(HashMap<String, Object> resultMap);

	List<CompanyVo> JJIMList(String userID);

	String JJIMLSTAT(Map<String, String> scrapIds);

	List<CompanyVo> getUserinfo(String inusername, String title, String phone_number);

	void sendMassege2(Map<String, Object> resultMap);

	void sendMassege(Map<String, Object> resultMap);

	List<CompanyVo> getJJIM(String userId, String title);

	String isJJIM(String userId, String title);

	void toggleJJIM(String userId, String title);

	void saveJJIM(CompanyVo companyVo);

	List<IndividualVo> getMessages(String user_id);

	// List<CompanyVo> getMatching(String career, String department, String workspace, String edu);

	List<CompanyVo> getScoreList(String compname);

	// List<CompanyVo> getMatching(Map<String, Object> params);

	List<CompanyVo> getMatching(@Param("career") String career, 
            @Param("department") String department,
            @Param("workspace") String workspace,
            @Param("edu") String edu);

	int checkCompanyUser(String user_id);

	List<IndividualVo> getResumesByPostIds(List<IndividualVo> appList);

	List<CompanyVo> getAllCompany();
	
	void updateAverage(String compname);
	
	double getCompanyAverage(@Param("compname") String compname);
	
	List<CompanyVo> getSearchtextList(
			@Param("searchtext") String searchtext
			);


}
