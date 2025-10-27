package com.board.individual.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.company.mapper.CompanyMapper;
import com.board.company.vo.CompanyVo;
import com.board.individual.mapper.IndividualMapper;
import com.board.individual.vo.IndividualVo;
import com.board.mapper.CommentMapper;
import com.board.picktalk.mapper.CompanyReviewsMapper;
import com.board.vo.CommentVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Individual")
public class IndividualController {
	
	@Autowired
	private CompanyMapper    companyMapper;
	
	@Autowired
	private IndividualMapper individualMapper;
	
	@Autowired
	private CompanyReviewsMapper companyReviewsMapper;
	
	@Autowired
	private CommentMapper commentMapper;
	
	// ------------------------------- 로그인 -------------------------------//
	// Individual/Login (로그인)
	@GetMapping("/Login")
    public String loginForm(Model model) {
        return "/individual/login"; 
    }
	
	@PostMapping("/Login")
    public String login(HttpServletRequest  request, 
    					HttpServletResponse response,
    					RedirectAttributes redirectAttributes) {
        String user_id = request.getParameter("user_id"); 
        String password = request.getParameter("password");

        IndividualVo individualVo = individualMapper.login(user_id, password); 

        HttpSession session = request.getSession();

        if (individualVo != null) {
            session.setAttribute("login", individualVo);
            return "redirect:/Individual/Main?user_id=" + user_id; 
        } else {
        	redirectAttributes.addFlashAttribute
        	("errorMessage", "로그인 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/Individual/Login"; 
        }
	}
	// ------------------------------- 로그아웃 -------------------------------//
	// Individual/Logout (로그아웃)
	@RequestMapping(value="/Logout",
		method = RequestMethod.GET)
		public   String   logout(
				HttpServletRequest    request,
				HttpServletResponse   response,
				HttpSession           session
				) {

		//Object url = session.getAttribute("URL");
		session.invalidate();

		//return "redirect:" + (String) url;
		return "redirect:/";
		}
	
	// ------------------------------- 홈 화면 -------------------------------//
	// /Home (홈 화면)
	@RequestMapping("/")
	public String home() {
		return "views/home";
	}
	
	// ------------------------------- 메인 화면 -------------------------------//
	// Individual/Main (메인 화면)
	 @RequestMapping("/Main")
	 public String main(
			 @RequestParam(defaultValue = "1") int page, 
             @RequestParam(defaultValue = "8") int size, 
             @RequestParam String user_id, 
             Model model,
             IndividualVo individualVo) {
		 String compname = companyMapper.compnameByUserId(user_id);
		 
		 int start = (page - 1) * size; 
		 int totalPosts = companyMapper.getmainTotalPost();
		 int totalPages = (int) Math.ceil((double) totalPosts / size);

		 List<CompanyVo> postList = companyMapper.getmainPostList(start, size);
		 
		 List<IndividualVo> recommendList = individualMapper.recommendList(user_id,start,size); 
		 System.out.println("recommendList: " + recommendList);
		 
		 // 알림
		 List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
		 
		      Map<String, Object> resultMap = new HashMap<>();
		  if (!recommendList.isEmpty()) {
		     // userinfo의 첫 번째 요소에서 필요한 정보 추출
		  for (int i = 0; i < recommendList.size(); i++) { 
		  IndividualVo user = recommendList.get(i);
		 
		     resultMap.put("compuser_id", user.getUser_id());
		     resultMap.put("compname", user.getCompname()); // compname을 가져오는 메서드가 필요합니다.
		     resultMap.put("post", user.getPost_id()); // 
		     resultMap.put("user_id",  individualVo.getUser_id());
		     resultMap.put("username", individualVo.getUsername());
		     resultMap.put("email", user.getEmail());
		   
		      System.out.println(resultMap);
		     if(resultMap !=null) {
		      
		      String dupmessage = individualMapper.checkdupmes(resultMap);
		     
		      if (dupmessage == null) {
		       individualMapper.sendAIMassege(resultMap);// 현재 날짜로 설정
		           }       
		        }
		    } 
		  
		 }
		 
		 model.addAttribute("postList", postList);
		 model.addAttribute("messagelist", messagelist);
		 model.addAttribute("totalPages", totalPages);
		 model.addAttribute("currentPage", page);
		 model.addAttribute("user_id", user_id); 
	        return "/individual/main"; 
	    }
	 //-------------------------------메인화면 검색 기능-----------------------//
	 
	 @RequestMapping("/SearchCheck")
	   @ResponseBody
	     public Map<String,Object> searchcheck(
	    		 @RequestParam(required = false, value="searchtext") String searchtext
	    		 ){
		 
		 System.out.println("searchtext : "+searchtext);
		 List<CompanyVo> searchlist = companyMapper.getSearchtextList(searchtext);
		 System.out.println("searchlist : "+searchlist);
		 Map<String, Object> response = new HashMap<>();
		 System.out.println("response : " + response);
		 response.put("searchlist", searchlist);
		 return response;
	 }
	// ------------------------------- 회원가입 -------------------------------//
	// Individual/Signup (회원가입)
    @RequestMapping("/Signup")
    public ModelAndView signup() {    
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/individual/signup");
        return mv;
    }
    // Individual/SignupForm (회원가입)
    @RequestMapping("/SignupForm")
    public ModelAndView signupFrom(IndividualVo individualVo) {
        individualMapper.signup(individualVo);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Individual/Login"); 
        return mv;
    }
	// 아이디 중복 확인
    @RequestMapping(
    		value   = "/IdDupCheck",
    		method  = RequestMethod.GET,
    		headers = "Accept=application/json" )  
    	@ResponseBody                           
    	public  IndividualVo   idDupCheck(String user_id) {
    		String  result = "";  
    		IndividualVo  individualVo = individualMapper.idDupCheck( user_id  );		
    		return  individualVo;
    	} 
 // 이메일 중복 확인
    @RequestMapping(
            value = "/EmailDupCheck",
            method = RequestMethod.GET,
            headers = "Accept=application/json")
        @ResponseBody
        public IndividualVo emailDupCheck(String email , String originalEmail) { 
       if (email.equals(originalEmail)) {
            return null;
        }
       IndividualVo individualemailVo = individualMapper.emailDupCheck(email);
            System.out.println(individualemailVo);
            return individualemailVo;
           } 
	// ------------------------------- 마이페이지 -------------------------------//
	// Individual/Mypage (마이페이지)
	// http://localhost:9090/Individual/Mypage?user_id=user1
	@RequestMapping("/Mypage")
	public String mypage(IndividualVo individualVo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		IndividualVo login = (IndividualVo) session.getAttribute("login");
	
		String userid = login.getUser_id();
		IndividualVo vo = individualMapper.getUserById(userid);		
		
		model.addAttribute("vo", vo);
		return "individual/mypage";
	}
	
	// Individual/UpdateForm (마이페이지 수정)
	// http://localhost:9090/Individual/UpdateForm?user_id=user1
	@RequestMapping("/UpdateForm")
	public String updateForm(IndividualVo individualVo, Model model) {
		// 수정할 자료 조회
		IndividualVo vo = individualMapper.getUserById(individualVo.getUser_id());	
		model.addAttribute("vo", vo);
		
		return "individual/update";
	}
	// Individual/Update (마이페이지 수정)
	@RequestMapping("/Update")
	public String update(IndividualVo individualVo) {
		// 수정하기
		individualMapper.update(individualVo);
		String user_id = individualVo.getUser_id();
		System.out.println("user_id는:" + user_id);
		// 수정 후 목록조회
		return "redirect:/Individual/Mypage?user_id=" + user_id;
	}
	// Individual/Delete (마이페이지_회원탈퇴)
	@RequestMapping("/Delete")
	public String delete(IndividualVo individualVo, RedirectAttributes redirectAttributes) {
		System.out.println("IndividualVo는" + individualVo );
		individualMapper.delete(individualVo);
		String user_id = individualVo.getUser_id();
		redirectAttributes.addFlashAttribute("message", "회원탈퇴가 완료되었습니다.");
		return "redirect:/Individual/Login";
	}
	
	// ------------------------------- 채용공고 -------------------------------//

	//Individual/Postlist (채용공고 목록)
	@RequestMapping("/Postlistfilter")
	public ModelAndView postlist(
			@RequestParam(defaultValue = "1") int page, 
	        @RequestParam(defaultValue = "5") int size,
	        @RequestParam(required = false) String sort,
	        @RequestParam String user_id,
			IndividualVo individualVo
			) {
		
		int start = (page - 1) * size;
		int totalPosts = companyMapper.getreTotalPost(); 
		int totalPages = (int) Math.ceil((double) totalPosts / size);
	    
		List<CompanyVo> mainList = companyMapper.getrePostList(start, size,sort);
		
		// 알림
		List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
				
	    List<String> scrapStatuses = new ArrayList<>();
	    for (CompanyVo company : mainList) {
	        String companyId = company.getPost_id();
	        String compname = company.getCompname(); 
	        String scrapStatus = companyId != null ? individualMapper.IsOnScrap(user_id, companyId, compname) : null;
	        if (scrapStatus != null) {
	            if ("ON".equals(scrapStatus)) {
	                scrapStatuses.add("yellow"); // ON일 경우 yellow
	            } else {
	                scrapStatuses.add("none"); // OFF일 경우 none
	            }
	        } else {
	            scrapStatuses.add("none"); // NULL로 저장
	        }
	    }
	    System.out.println(scrapStatuses);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainList", mainList);
		mv.addObject("messagelist", messagelist);
		mv.addObject("scrapStatus", scrapStatuses);
		mv.addObject("currentPage", page);
	    mv.addObject("totalPages", totalPages);
	    mv.addObject("user_id", user_id);
		mv.setViewName("individual/postlistfilter");
		return mv ;
		}
	@RequestMapping("/Postlistsort")
	public ModelAndView postlistsort(
	        @RequestParam(defaultValue = "1") int page, 
	        @RequestParam(defaultValue = "5") int size,
	        @RequestParam String user_id,
	        @RequestParam(required = false) String sort, 
	        IndividualVo individualVo
	) {
	    int start = (page - 1) * size;
	    int totalPosts = companyMapper.getreTotalPost(); 
	    int totalPages = (int) Math.ceil((double) totalPosts / size);
	    
	    // 정렬 기준에 따라 게시글 리스트 가져오기
	    List<CompanyVo> mainList = companyMapper.getrePostList(start, size, sort); 
	    
	    // 알림
	    List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
	            
	    List<String> scrapStatuses = new ArrayList<>();
	    for (CompanyVo company : mainList) {
	        String companyId = company.getPost_id();
	        String compname = company.getCompname(); 
	        String scrapStatus = companyId != null ? individualMapper.IsOnScrap(user_id, companyId, compname) : null;
	        if (scrapStatus != null) {
	            if ("ON".equals(scrapStatus)) {
	                scrapStatuses.add("yellow"); // ON일 경우 yellow
	            } else {
	                scrapStatuses.add("none"); // OFF일 경우 none
	            }
	        } else {
	            scrapStatuses.add("none"); // NULL로 저장
	        }
	    }
	    
	    ModelAndView mv = new ModelAndView();
	    mv.addObject("mainList", mainList);
	    mv.addObject("messagelist", messagelist);
	    mv.addObject("scrapStatus", scrapStatuses);
	    mv.addObject("currentPage", page);
	    mv.addObject("totalPages", totalPages);
	    mv.addObject("user_id", user_id);
	    mv.addObject("selectedSort", sort); 
	    mv.setViewName("individual/postlistsort");
	    return mv;
	}

		
	//Individual/Postview (채용공고 상세페이지)
	// http://localhost:9090/Individual/View?aplnum=1
	@RequestMapping("/Postview")
	public ModelAndView postview(CompanyVo companyVo ,IndividualVo individualVo ,HttpServletRequest request, Model model) {
					
		//조회수 증가
		companyMapper.plushit(companyVo);
		// System.out.println("plusint"+companyVo);
		
		//글 조회
		CompanyVo vo = companyMapper.getmain(companyVo);
		//System.out.println("vo"+vo);
		
		//기업정보 조회
		String compname = vo.getCompname();
		CompanyVo comp = companyMapper.getcomp(compname);
		
		//담당자정보 조회
		String userId = vo.getUser_id();
		CompanyVo user = companyMapper.getuser(userId);
		//System.out.println("user"+user);
		
		// 기업의 평균 평점과 총 리뷰 수 조회
	    double averageRating = companyMapper.getCompanyAverage(compname);
	    int totalReviews = companyReviewsMapper.getTotalReviewsCount(compname);

	    
		// 북마크 색상
		String companyId =vo.getPost_id();
		String user_id = individualVo.getUser_id();
		//System.out.println("comp"+comp);
		
		List<String> scrapStatuses = new ArrayList<>();
        String scrapStatus = companyId != null ? individualMapper.IsOnScrap(user_id, companyId, compname) : null;
        if (scrapStatus != null) {
            if ("ON".equals(scrapStatus)) {
                scrapStatuses.add("yellow"); // ON일 경우 yellow
            } else {
                scrapStatuses.add("none"); // OFF일 경우 none
            }
        } else {
            scrapStatuses.add("none"); // NULL일 경우 none
       }
	    
	    System.out.println("선택한 공고의 북마크:"+scrapStatuses);
	    String firstScrapStatus = scrapStatuses.isEmpty() ? "none" : scrapStatuses.get(0);
		
			
		String       duty   =  vo.getDuty().replace("\n", "<br>");
		vo.setDuty( duty );
			
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo",vo );
		mv.addObject("comp",comp );
		mv.addObject("user",user );
		mv.addObject("scrapStatus",firstScrapStatus );
		mv.addObject("averageRating", averageRating); 
	    mv.addObject("totalReviews", totalReviews);
		mv.setViewName("individual/postview");

		return mv;		
   		}
		
	//채용공고 지원 //
	@RequestMapping("/Postapp")
	public ModelAndView postapp(String user_id, CompanyVo companyVo ,IndividualVo individualVo ,HttpServletRequest request, Model model) {
			
		CompanyVo vo = companyMapper.getmain(companyVo);
					
		String       duty   =  vo.getDuty().replace("\n", "<br>");
		vo.setDuty( duty );  
			
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo",vo );				
		mv.setViewName("individual/postapp");
		List<String> titles = individualMapper.getTitlesByUSerId(user_id);
		System.out.println("titles"+titles);
		
		model.addAttribute("titles", titles);			
		return mv;
    	}
	
	//채용공고 지원내역 확인  수정됨 
	
	@RequestMapping(value = "/CheckDuplicateApplication", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> checkDuplicateApplication(IndividualVo individualVo, String user_id , String aplnum) {
		List<IndividualVo> isDuplicate = individualMapper.checkappex(user_id, aplnum);
	     System.err.println("2"+isDuplicate);
	     boolean submitted = (isDuplicate != null && !isDuplicate.isEmpty());
		    
		    Map<String, Object> response = new HashMap<>();
		    response.put("submitted", submitted);
		    
		    return response;
	}

	
	//채용공고 등록 //
	@RequestMapping("/WriteForm2")
    public ModelAndView writeForm2() {    
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/individual/write");
        return mv;
    }
	    
    @RequestMapping("/Write2")
    public ModelAndView white(IndividualVo individualVo, CompanyVo companyVo , String user_id) {
        individualMapper.insert2(individualVo);
        System.out.println("제출정보:"+ individualVo);
        
        Map<String, Object> resultMap = new HashMap<>();
        
        IndividualVo userinfo = individualMapper.getUserById(user_id);
        
        
           // individualVo가 유효한지 체크
           if (individualVo != null) {
               // 개인 정보에서 필요한 정보 추출
               
               resultMap.put("aplnum", individualVo.getAplnum());
               resultMap.put("post_id", individualVo.getPost_id());         
               resultMap.put("user_id", userinfo.getUser_id());
               resultMap.put("username", userinfo.getUsername());
               resultMap.put("email", individualVo.getEmail());
               
          IndividualVo cuserinfo = individualMapper.getCUserById(resultMap);
          
               resultMap.put("compuser_id", cuserinfo.getUser_id());
              resultMap.put("compname", cuserinfo.getCompname());
           
               System.out.println(resultMap);
               individualMapper.sendPostappMassege(resultMap); 
           }
		System.out.println("user_id는:" + user_id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Individual/AppList?user_id=" + user_id); 
        return mv;
    }
	    
	
	// ------------------------------- 이력서 등록 -------------------------------//
	
	//Individual/Resumereg (이력서등록)
	@RequestMapping("/Resumereg")
	public String resumereg(IndividualVo individualVo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		IndividualVo login = (IndividualVo) session.getAttribute("login");
	
		String userid = login.getUser_id();
		IndividualVo vo = individualMapper.getUserById(userid);		
		
		// 알림
		List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
		
		model.addAttribute("vo", vo); 
		model.addAttribute("messagelist", messagelist); 
		return "individual/resumereg";
	}	
	@RequestMapping("/WriteForm")
    public ModelAndView write() {    
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/individual/write");
        return mv;
    }
    
	@RequestMapping("/Write")
	   public ModelAndView signupForm(
	           @RequestParam("photo") MultipartFile photo, 
	           @RequestParam("portfolio") MultipartFile portfolio, // 포트폴리오 파일 추가
	           IndividualVo individualVo) {   

	       // 사진 파일 저장 경로
	       String img = "D:\\dev\\spring\\TeamProject1\\src\\main\\resources\\static\\photo"; 
	       
	       // 파일 저장 경로 설정 (사진)
	       String originalFilename = photo.getOriginalFilename(); 
	       String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase(); 

	       // UUID를 사용하여 고유한 파일 이름 생성 (중복 방지)
	       String uniqueFileName = UUID.randomUUID().toString() + "." + extension; 
	       String filePath = img + "/" + uniqueFileName; 

	       try {
	           // 디렉토리가 존재하지 않으면 생성
	           File directory = new File(img);
	           if (!directory.exists()) {
	               directory.mkdirs(); 
	           }

	           // 사진 파일 저장
	           photo.transferTo(new File(filePath));
	           individualVo.setPhotoPath("/photo/" + uniqueFileName); // DB에 저장할 경로 설정

	       } catch (Exception e) {
	           e.printStackTrace();
	           // 파일 저장 실패 시 처리 로직 추가
	       }

	       // 포트폴리오 파일 저장 경로
	       String portfolioPath = "D:\\dev\\spring\\TeamProject1\\src\\main\\resources\\static\\portfolio"; // 포트폴리오 저장 경로
	       
	       // 포트폴리오 파일 저장
	       if (!portfolio.isEmpty()) {
	           String originalPortfolioFilename = portfolio.getOriginalFilename();
	           String portfolioExtension = originalPortfolioFilename.substring(originalPortfolioFilename.lastIndexOf(".") + 1).toLowerCase();
	           String uniquePortfolioFileName = UUID.randomUUID().toString() + "." + portfolioExtension; 
	           String portfolioFilePath = portfolioPath + "/" + uniquePortfolioFileName; 

	           try {
	               // 디렉토리가 존재하지 않으면 생성
	               File portfolioDirectory = new File(portfolioPath);
	               if (!portfolioDirectory.exists()) {
	                   portfolioDirectory.mkdirs();
	               }

	               // 포트폴리오 파일 저장
	               portfolio.transferTo(new File(portfolioFilePath));
	               individualVo.setPortfolioPath("/portfolio/" + uniquePortfolioFileName); // DB에 저장할 경로 설정

	           } catch (Exception e) {
	               e.printStackTrace();
	               // 포트폴리오 파일 저장 실패 시 처리 로직 추가
	           }
	       }

	       // DB에 데이터 저장
	       individualMapper.insert(individualVo);
	       
	       String user_id = individualVo.getUser_id();
	       IndividualVo vo = individualMapper.getUserById(user_id);      
	       ModelAndView mv = new ModelAndView();
	       mv.setViewName("redirect:/Individual/ResumeList?user_id=" + user_id); 
	       return mv;
	   }

   //제출 이력서 (제목중복확인)
    @RequestMapping(value = "/Checktitle", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checktitle(@RequestBody IndividualVo individualVo) {
        String userId = individualVo.getUser_id(); // IndividualVo에서 user_id 추출
        String title = individualVo.getTitle(); // IndividualVo에서 title 추출

        List<IndividualVo> isDuplicate = individualMapper.checkTitleExists(userId, title);
        System.err.println("2"+isDuplicate);
        boolean submitted = (isDuplicate != null && !isDuplicate.isEmpty());

        Map<String, Object> response = new HashMap<>();
        response.put("submitted", submitted);

        return response;
    }

 // ------------------------------- 이력서 -------------------------------//
    //Company/ResumeList (이력서 목록)
    @RequestMapping("/ResumeList")
    public ModelAndView resumeList(
          @RequestParam(defaultValue = "1") int page, 
             @RequestParam(defaultValue = "5") int size,
             IndividualVo individualVo, 
             HttpServletRequest request, 
             @RequestParam String user_id, 
             String compname
          ) {
       int start = (page - 1) * size;
       int retotalPosts = individualMapper.getReListCount(user_id);  
         int retotalPages = (int) Math.ceil((double) retotalPosts / size);
         
       HttpSession session = request.getSession();
       IndividualVo login = (IndividualVo) session.getAttribute("login");
    
       String userid = login.getUser_id();
       IndividualVo vo = individualMapper.getUserById(userid);   
          
       // 알림
       List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
       
        List<IndividualVo> reList = individualMapper.getreList(vo, user_id, start, size);
        System.out.println(" reList: " + reList);
        System.out.println("총 이력서 : " + retotalPosts);
        
        ModelAndView mv = new ModelAndView();
         mv.addObject("reList", reList);
         mv.addObject("messagelist", messagelist);
         mv.addObject("user_id", user_id);
         mv.addObject("compname", compname);
         mv.addObject("currentPage", page); 
         mv.addObject("totalPages", retotalPages); 
         mv.setViewName("individual/resumeList");

       return mv;
    } 
    //Company/AppList ( 지원서 목록)
          @RequestMapping("/AppList")
          public ModelAndView appList(
                @RequestParam(defaultValue = "1") int page, 
                   @RequestParam(defaultValue = "5") int size,
                   IndividualVo individualVo, 
                   HttpServletRequest request, 
                   @RequestParam String user_id, 
                   String compname
                ) {
             int start = (page - 1) * size;
               int apptotalPosts = individualMapper.getAppListCount(user_id); 
               int apptotalPages = (int) Math.ceil((double) apptotalPosts / size);
               
             HttpSession session = request.getSession();
             IndividualVo login = (IndividualVo) session.getAttribute("login");
          
             String userid = login.getUser_id();
             IndividualVo vo = individualMapper.getUserById(userid);   
                
             // 알림
             List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
             
             List<IndividualVo> appList = individualMapper.getappList(vo, user_id, start, size);
              
              ModelAndView mv = new ModelAndView();
               mv.addObject("appList", appList);
               mv.addObject("messagelist", messagelist);
               mv.addObject("user_id", user_id);
               mv.addObject("compname", compname);
               mv.addObject("currentPage", page); 
               mv.addObject("totalPages", apptotalPages); 
               mv.setViewName("individual/appList");

             return mv;
          }
          
	      //------------------------- 지원서 삭제 ----------------------------------   수정됨  //
	  @RequestMapping("/Delapplist")
	  public ModelAndView delappList(
			  @RequestParam(defaultValue = "1") int page, 
		      @RequestParam(defaultValue = "5") int size,
		      IndividualVo individualVo, 
		      HttpServletRequest request, 
		      String user_id, 
		      String app_id) {
		  HttpSession session = request.getSession(); 
		  System.out.println("user_id=" +  user_id);
		  IndividualVo login = (IndividualVo) session.getAttribute("login");
	 
	      String userid = login.getUser_id(); 
	      IndividualVo vo =  individualMapper.getUserById(userid);
	  
	      Map<String, Object> resultMap = new HashMap<>();
	      IndividualVo userinfo = individualMapper.getUserById(user_id);
	      
	      int start = (page - 1) * size;
	      
	      List<IndividualVo> appList = individualMapper.getappList(vo,user_id,start,size);
	      List<IndividualVo> reList = individualMapper.getreList(vo,user_id,start,size);
	  
	      System.out.println("appdellist=" + appList); 
	      System.out.println("redellist="+	 reList);
	      individualMapper.delapplist(individualVo);
	      
	      // individualVo가 유효한지 체크
	      if (individualVo != null) {
	             // 개인 정보에서 필요한 정보 추출
	             if (!appList.isEmpty()) {
	                    IndividualVo appInfo = appList.get(0); 
	                    resultMap.put("aplnum", appInfo.getAplnum());
	                    resultMap.put("post_id", appInfo.getPost_id());
	                }
	                
	                resultMap.put("user_id", userinfo.getUser_id());
	                resultMap.put("username", userinfo.getUsername());
	                resultMap.put("email", individualVo.getEmail());
	                
	                IndividualVo cuserinfo = individualMapper.getCUserById(resultMap);
	                
	                resultMap.put("compuser_id", cuserinfo.getUser_id());
	                resultMap.put("compname", cuserinfo.getCompname());

	                System.out.println(resultMap);
	                individualMapper.sendPostappMassege2(resultMap); 
	            }
	      
	      ModelAndView mv = new ModelAndView(); System.out.println(user_id);
	      mv.addObject("appList", appList); 
	      mv.setViewName("redirect:/Individual/ResumeList?user_id=" + user_id); // 리다이렉션 URL 수정
	       
	      return mv; 
	  }
	  
	
	 
	//Company/Resumeview (이력서 상세페이지)
	// http://localhost:9090/Company/Resumview?resume_id=1001
	@RequestMapping("/Resumeview")
	public ModelAndView resumeview(IndividualVo individualVo, String title) {				
		//이력서 조회
		IndividualVo vo = individualMapper.getresumeList(individualVo);
		System.out.println("vo"+vo);
		
		title = title.replaceAll(" ", "");
		System.out.println("Title without spaces: " + title);
		
		ModelAndView mv = new ModelAndView();
		//mv.addObject("vo",vo );
		mv.addObject("vo", vo);
		mv.addObject("title", title);
		mv.setViewName("individual/resumeview");
		return mv;
	}
	
	//이력서 상세보기(보는것만) 수정됨
	
		@RequestMapping("/Resumejustview")
		public ModelAndView resumejustview(IndividualVo individualVo, String title, String user_id) {				
			//이력서 조회
			IndividualVo vo = individualMapper.getresumeList(individualVo);
			System.out.println("vo"+vo);
			
			// System.out.println("Title without spaces: " + title);
			
			ModelAndView mv = new ModelAndView();
			mv.addObject("vo", vo);
			mv.addObject("title", title);
			mv.addObject("user_id", user_id);
			mv.setViewName("individual/resumejustview");
			return mv;
		
		}

	// 이력서 수정하기 
	@RequestMapping("/Resumeupdate")
	public ModelAndView resumeupdate(IndividualVo individualVo, String title) {				
		//이력서 조회
		IndividualVo vo = individualMapper.getresumeList(individualVo);
		System.out.println("vo2"+vo);
		
		
		String user_id = individualVo.getUser_id();
		System.out.println("user_id는:" + user_id);
		System.out.println("Title without spaces: " + title);
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo", vo);
		mv.addObject("user_id",user_id);
		mv.addObject("title", title);
		mv.setViewName("individual/resumeupdate");
		return mv;
		}
	
	@RequestMapping("/UpdatingForm")
	public ModelAndView updatingForm() {    
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/individual/Updating");
		return mv;
		}

	@RequestMapping("/Updating")
	public ModelAndView updating(IndividualVo individualVo,
	        @RequestParam(value = "photo", required = false) MultipartFile photo,
	        @RequestParam(value = "portfolio", required = false) MultipartFile portfolio) {
	    
	    // 사진 파일 저장 경로
	    String imgPath = "D:\\dev\\spring\\TeamProjectf\\src\\main\\resources\\static\\photo"; 
	  //String img = "C:\Users\SAMSUNG\Desktop\d\dev\spring\TeamProject1\src\main\resources\static\photo"; // 가영 경로
	    // 사진 파일이 존재할 경우 처리
	    if (photo != null && !photo.isEmpty()) {
	        String originalFilename = photo.getOriginalFilename();
	        String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
	        String uniqueFileName = UUID.randomUUID().toString() + "." + extension;
	        String filePath = imgPath + "/" + uniqueFileName;
	        
	        try {
	            // 디렉토리 생성
	            File directory = new File(imgPath);
	            if (!directory.exists()) {
	                directory.mkdirs();
	            }

	            // 파일 저장
	            photo.transferTo(new File(filePath));
	            individualVo.setPhotoPath("/photo/" + uniqueFileName); // DB에 저장할 경로 설정
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            // 파일 업로드 실패 시 처리 로직 추가
	        }
	    }

	    // 포트폴리오 파일 저장 경로
	    String portfolioPath = "D:\\dev\\spring\\TeamProjectf\\src\\main\\resources\\static\\portfolio"; 
	  //String img = "C:\Users\SAMSUNG\Desktop\d\dev\spring\TeamProject1\src\main\resources\static\portfolio"; // 가영 경로
	    // 포트폴리오 파일이 존재할 경우 처리
	    if (portfolio != null && !portfolio.isEmpty()) {
	        String originalPortfolioFilename = portfolio.getOriginalFilename();
	        String portfolioExtension = originalPortfolioFilename.substring(originalPortfolioFilename.lastIndexOf(".") + 1).toLowerCase();
	        String uniquePortfolioFileName = UUID.randomUUID().toString() + "." + portfolioExtension;
	        String portfolioFilePath = portfolioPath + "/" + uniquePortfolioFileName;

	        try {
	            // 디렉토리 생성
	            File portfolioDirectory = new File(portfolioPath);
	            if (!portfolioDirectory.exists()) {
	                portfolioDirectory.mkdirs();
	            }

	            // 포트폴리오 파일 저장
	            portfolio.transferTo(new File(portfolioFilePath));
	            individualVo.setPortfolioPath("/portfolio/" + uniquePortfolioFileName); // DB에 저장할 경로 설정
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            // 포트폴리오 파일 업로드 실패 시 처리 로직 추가
	        }
	    }

	    // 이력서 정보 수정
	    individualMapper.update2(individualVo);
	    System.out.println("IndividualVo: " + individualVo);
	    System.out.println("완료");

	    String user_id = individualVo.getUser_id();
	    ModelAndView mv = new ModelAndView();
	    mv.addObject("message", "이력서가 성공적으로 수정되었습니다."); // 성공 메시지 추가
	    mv.setViewName("redirect:/Individual/ResumeList?user_id=" + user_id); 
	    return mv;
	}
	
	
	//제출된 이력서 확인 수정됨 
	@RequestMapping(value = "/CheckSubmittedResume", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> checkSubmittedResume(IndividualVo individualVo, String title, String user_id) {
	    List<IndividualVo> userResumes = individualMapper.getsubres(user_id, title);
	    
	    boolean submitted = (userResumes != null && !userResumes.isEmpty());
	    
	    Map<String, Object> response = new HashMap<>();
	    response.put("submitted", submitted);
	    
	    return response;
	}
	
	// 삭제 
	@RequestMapping("/Deleteres")
		public String deleteres(IndividualVo individualVo, RedirectAttributes redirectAttributes) {
		System.out.println("IndividualVo는" + individualVo );
	    individualMapper.delbookmark(individualVo);
		individualMapper.deleteres(individualVo);
	
	
		String user_id = individualVo.getUser_id();
		System.out.println(user_id);
		redirectAttributes.addFlashAttribute("message", "선택한 이력서가 삭제되었습니다");
		return "redirect:/Individual/ResumeList?user_id=" + user_id;
		}
	
	// ------------------------------- 개인: 기업 추천 -------------------------------//
	@RequestMapping("/Recommend")
	public ModelAndView recommend(
			@RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "5") int size,
            @RequestParam String user_id,
			IndividualVo individualVo 
			) {   		
		int start = (page - 1) * size;
		
		List<IndividualVo> recommendList = individualMapper.recommendList(user_id,start,size); 
		// 중복제거
		Set<IndividualVo> uniqueRecommendations = new HashSet<>(recommendList);
		List<IndividualVo> finalList = new ArrayList<>(uniqueRecommendations);
	    System.out.println("finalList: " + finalList);
	    
		int totalPosts = finalList.size(); // 중복 제거된 리스트 총 수
		int totalPages = (int) Math.ceil((double) totalPosts / size);
		// 최종 리스트에서 start와 size에 맞게 서브 리스트를 생성합니다.
	    List<IndividualVo> paginatedList = finalList.stream()
	            .skip(start)
	            .limit(size)
	            .collect(Collectors.toList()); 
	    
	    //알림
	    List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());

	    ModelAndView mv = new ModelAndView();
		mv.addObject("finalList", finalList);
		mv.addObject("messagelist", messagelist);
		mv.addObject("recommendations", paginatedList);
		mv.addObject("totalPages", totalPages);
		mv.addObject("currentPage", page);
		mv.addObject("user_id", user_id);
	    mv.setViewName("/individual/recommend");
	    return mv;
	}
	
	// ------------------------------- 스크랩 -------------------------------//
		@RequestMapping("/Scrap")
		public ModelAndView scrap(
				@RequestParam(defaultValue = "1") int page, 
	            @RequestParam(defaultValue = "5") int size,
	            @RequestParam String user_id,
				IndividualVo individualVo 
				) {   		   
			int start = (page - 1) * size;
			
		    List<IndividualVo> scrapList = individualMapper.ScrapList(user_id,start,size);
		    System.out.println("scrapList: " + scrapList);
		    
			int totalPosts = scrapList.size(); // 중복 제거된 리스트 총 수
			int totalPages = (int) Math.ceil((double) totalPosts / size);
			
			// 최종 리스트에서 start와 size에 맞게 서브 리스트를 생성합니다.
		    List<IndividualVo> paginatedList = scrapList.stream()
		            .skip(start)
		            .limit(size)
		            .collect(Collectors.toList());
			
		    //알림
		    List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
		    
		    List<Map<String, String>> scrapListData = new ArrayList<>();
		    List<String> scrapStatuses = new ArrayList<>();
		    
		    for (IndividualVo individual : scrapList) {
		    	 String compname = individual.getCompname().trim();
		    	 String postId   = individual.getPost_id().trim();
		    	 String deadline = individual.getDeadline().trim();
		    	 String jjim = individual.getJjim().trim();
		    	 // String dateonly = deadline.substring(0, 10); // "2024-11-23"
		    	 System.out.println("postId; " + postId );
		    	 String aplnum = individualMapper.getalpnum(compname, postId, deadline);
		    	    
		    	    // scrapIds에 추가
		 	    Map<String,String> scrapIds = new HashMap<>();
		    	    scrapIds.put("compname",compname);
		    	    scrapIds.put("post_id",postId);
		    	    scrapIds.put("deadline",deadline);
		    	    scrapIds.put("alpnum",aplnum);
		    	    scrapIds.put("jjim",jjim);
		 
		    	    String scrapStatus = postId != null ? individualMapper.IsOnScrap(user_id, postId, compname) : null;
		    	    System.out.println("scrapStatus: " + scrapStatus);
		    	    
		            if (scrapStatus != null) {
		                if ("ON".equals(scrapStatus)) {
		                    scrapStatuses.add("yellow"); // ON일 경우 yellow
		                } else {
		                    scrapStatuses.add("none"); // OFF일 경우 none
		                }
		            } else {
		                scrapStatuses.add("none"); // NULL로 저장
		            }
		            scrapListData.add(scrapIds); // scrapListData에 추가
		            System.out.println("scrapIds: " + scrapIds);     
		        }
		    System.out.println("scrapStatuses: " + scrapStatuses);
		    System.out.println("scrapListData: " + scrapListData);
		    
		    
		        ModelAndView mv = new ModelAndView();
		        mv.addObject("scrapListData", scrapListData); 
		        mv.addObject("scrapStatuses", scrapStatuses); 
		        mv.addObject("scrapIds", scrapListData);
			    mv.addObject("messagelist", messagelist);
			    mv.addObject("recommendations", paginatedList);
			    mv.addObject("totalPages", totalPages);
			    mv.addObject("currentPage", page);
			    mv.addObject("user_id", user_id);
		        mv.setViewName("/individual/scrap");
		        return mv;
		}

	// ------------------------------- 북마크(PICK ME기능)  -------------------------------//
	
	@RequestMapping("/Bookmarking")
	   public String bookmark(
			   @RequestParam(defaultValue = "1") int page, 
		       @RequestParam(defaultValue = "5") int size,
		       @RequestParam String user_id,
			   IndividualVo individualVo, 
			   Model model
			   ) {
	      
	      IndividualVo vo = individualMapper.getallUserById(user_id);
	      
	      if (vo == null) {
	           // 정보가 없을 경우, 적절한 처리 (예: 에러 메시지 추가)
	           model.addAttribute("errorMessage", "사용자 정보를 찾을 수 없습니다.");
	           return "individual/bookmark"; // 또는 다른 페이지로 리다이렉트
	       }
	      
	       // user_id를 사용하여 북마크 목록 가져오기
	      
		   int start = (page - 1) * size;
	       int totalPosts = individualMapper.getBookmarksCount(vo);
	       int totalPages = (int) Math.ceil((double) totalPosts / size);
	       
	       List<IndividualVo> bookmarkList = individualMapper.getBookmarksByUsername(vo, start, size);

	       List<IndividualVo> jobPostings = new ArrayList<>();
	       for (IndividualVo bookmark : bookmarkList) {
	           jobPostings.addAll(individualMapper.getJobPostingsByUserId(bookmark.getUser_id()));
	       }
	       
	       List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());
	       
	       model.addAttribute( "messagelist", messagelist);
	       model.addAttribute("bookmarkList", bookmarkList);
	       model.addAttribute("jobPostings", jobPostings);
	       model.addAttribute("currentPage", page);
	       model.addAttribute("totalPages", totalPages);
	       model.addAttribute("user_id", user_id);

	       return "individual/bookmark";
	   }
    // ------------------------------- 고객센터 -------------------------------//
 	// Company/Cslist (고객센터)
 	@RequestMapping("/Cslist")
 	public ModelAndView cslist(
	        @RequestParam(defaultValue = "1") int page, 
	        @RequestParam(defaultValue = "5") int size,
	        @RequestParam String user_id, 
	        Integer csp_id, 
	        String compname,
	        IndividualVo individualVo
	        ) {
 		int start = (page - 1) * size;
	    int totalPosts = companyMapper.getTotalCs();
	    int totalPages = (int) Math.ceil((double) totalPosts / size);
	    
	    List<CompanyVo> faqList = companyMapper.getfaqList();
	    System.out.println("faqList=" + faqList);

	    List<CompanyVo> csList = companyMapper.getcsList(user_id,start, size);
	    System.out.println("csList=" + csList);
	    
	    // 알림
	    List<IndividualVo> messagelist = individualMapper.getMessages(individualVo.getUser_id());

	    ModelAndView mv = new ModelAndView();
	    mv.addObject("faqList", faqList);
	    mv.addObject("csList", csList);
	    mv.addObject("messagelist", messagelist);
	    mv.addObject("csp_id", csp_id);
	    mv.addObject("totalPages", totalPages);
	    mv.addObject("currentPage", page);
	    mv.addObject("user_id", user_id);
	    mv.addObject("compname", compname);
 		mv.setViewName("individual/cslist");
 		return mv ;
 	}
 	// Company/Csview (문의글 상세페이지)
 	@RequestMapping("/Csview")
 	public ModelAndView csview(CompanyVo companyVo, CommentVo commentVo, String user_id, Integer csp_id, String csp_title) {
		companyVo.setCspId(csp_id);
	    CompanyVo vo = companyMapper.getcs(companyVo); // 필요한 경우 수정 필요
	    
	    // 댓글
	    List<CommentVo> commentList = commentMapper.commentList(csp_id);
	    
	    System.out.println("vo1111=" + vo);
	    ModelAndView mv = new ModelAndView();
	    mv.addObject("vo", vo);
	    mv.addObject("user_id", user_id);
	    mv.addObject("csp_id", csp_id);
	    mv.addObject("commentList", commentList);
	    mv.addObject("csp_title", csp_title);
 		mv.setViewName("individual/csview");
 		return mv;
 	}
 	// Company/CswriteForm (문의글 작성)
 	@RequestMapping("/CswriteForm")
 	public ModelAndView cswriteForm(CompanyVo companyVo,String user_id, String compname, Integer csp_id) {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("companyVo", companyVo);
		mv.addObject("user_id", user_id);
		mv.addObject("csp_id", csp_id);
 		mv.setViewName("individual/cswrite");
 		return mv;
 	}
 	// Company/Cswrite (문의글 작성)
 	@RequestMapping("/Cswrite")
 	public ModelAndView cswrite(CompanyVo companyVo,String user_id, String compname, Integer csp_id) {
	    if (user_id != null && !user_id.trim().isEmpty()) {
	        companyVo.setUser_id(user_id);
	    } else {
	        // user_id가 NULL일 경우 오류 처리를 추가하거나 디폴트 값을 설정
	        System.out.println("user_id가 NULL이어서 INSERT 실패");
	        // 필요하다면 예외를 던질 수도 있습니다.
	    }
		companyMapper.insertcs(companyVo);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("csp_id", csp_id);
 		mv.setViewName("redirect:/Individual/Cslist");
 		return mv;
 	}
 	// Company/CsupdateForm (문의글 수정)
 	@RequestMapping("/CsupdateForm")
 	public ModelAndView csupdateForm(CompanyVo companyVo, String user_id, String csp_title, String compname, Integer csp_id) {
		CompanyVo vo = companyMapper.getcs(companyVo);
		System.out.println("updatevo=" +vo );
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo",vo );
		mv.addObject("csp_id",csp_id );
		mv.addObject("user_id",user_id );
 		mv.setViewName("individual/csupdate");
 		return mv;
 	}
 	
 	// Company/Csupdate (문의글 수정)
 	@RequestMapping("/Csupdate")
 	public ModelAndView csupdate(CompanyVo companyVo, String user_id, Integer csp_id) {
		companyMapper.updatecs(companyVo);
			
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("csp_id", csp_id);
 		mv.setViewName("redirect:/Individual/Cslist");
 		return mv;
 	}
 	
	// Company/csdelete (문의글 삭제)
	@RequestMapping("/Csdelete")
	public ModelAndView csdelete(CompanyVo companyVo, String user_id, Integer csp_id) {
		companyMapper.deletecs(companyVo);
		System.out.println(user_id);
		System.out.println(companyVo);
		
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("csp_id", csp_id);
		mv.setViewName("redirect:/Individual/Cslist");
		return mv;
	}
	// Individual/Scrap (스크랩)
	@RequestMapping(value = "/Scrap", method = RequestMethod.POST)
	public String scrap(IndividualVo individualVo, String user_id , String currentUrl
	,RedirectAttributes redirectAttributes) {
	    String userid = individualVo.getUser_id();
	   
	    Map<String, Object> scrapMap = new HashMap<>();

	    // HashMap에 post_id를 키로 사용하여 IndividualVo 객체를 추가
	    scrapMap.put("user_id",  individualVo.getUser_id());
	    scrapMap.put("compname", individualVo.getCompname());
	    scrapMap.put("post_id",  individualVo.getPost_id());
	    scrapMap.put("deadline", individualVo.getDeadline());
	    
	    System.out.println("scrapMap: " + scrapMap);
	    
	    
	    List<IndividualVo> checkScrap = individualMapper.getScrap(scrapMap);
	    System.out.println("checkScrap:"+checkScrap);

	    ModelAndView mv = new ModelAndView();
	    String alertMessage = "";

		if (checkScrap != null && !checkScrap.isEmpty()) {
		// 북마크가 존재할경우, 북마크 상태 변경 ON/OFF.
		String isSrap= individualMapper.IsScrap(scrapMap);
		if ("ON".equals(isSrap)) {
		individualMapper.toggleScrap(scrapMap); // DB의 BOOKMARK 값이 ON일경우
		alertMessage = "스크랩! 취소 되었습니다."; 


		} else if ("OFF".equals(isSrap)) { // DB의 BOOKMARK 값이 OFF일경우
		individualMapper.toggleScrap(scrapMap);
		alertMessage = "스크랩! 추가 하셨습니다.";
		}
		} else {
		    // scrapMap을 사용하여 데이터베이스에 스크랩 정보 저장
		    individualMapper.saveScrap(scrapMap);
		  alertMessage = "스크랩! 추가 하셨습니다.";
		}
	
		redirectAttributes.addFlashAttribute("alertMessage", alertMessage);

	    mv.addObject("scrapMap",scrapMap);
	    mv.addObject("alertMessage", alertMessage);
	    return "redirect:" + currentUrl;

	}
}