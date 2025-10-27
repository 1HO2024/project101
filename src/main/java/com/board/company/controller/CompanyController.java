package com.board.company.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
@RequestMapping("/Company")
public class CompanyController {
	
	@Autowired
	private CompanyMapper companyMapper;
	
	@Autowired
	private IndividualMapper individualMapper;
	
	@Autowired
	private CompanyReviewsMapper companyReviewsMapper;

	@Autowired
	private CommentMapper commentMapper;
	
	// ------------------------------- 로그인 -------------------------------//
	// Company/Login (로그인)
	@GetMapping("/Login")
    public String loginForm(Model model) {
        return "/company/login"; 
    }
	
	@PostMapping("/Login")
    public String login(HttpServletRequest  request, 
    					HttpServletResponse response,
    					RedirectAttributes redirectAttributes) {
        String user_id = request.getParameter("user_id"); 
        String password = request.getParameter("password");

        CompanyVo companyVo = companyMapper.login(user_id, password); 
        System.out.println(companyVo);

        HttpSession session = request.getSession();

        if (companyVo != null) {
            session.setAttribute("login", companyVo);
            return "redirect:/Company/Main?user_id=" + user_id; 
        } else {
        	redirectAttributes.addFlashAttribute
        	("errorMessage", "로그인 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/Company/Login"; 
        }
	}
	// ------------------------------- 로그아웃 -------------------------------//
	// Company/Logout (로그아웃)
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
	   // Company/Main (메인 화면)
	 @RequestMapping("/Main")
	 public String main(@RequestParam(defaultValue = "1") int page, 
			            @RequestParam(defaultValue = "8") int size, 
			            @RequestParam String user_id, 
			            Model model,
			            CompanyVo companyVo) {
		 String compname = companyMapper.compnameByUserId(user_id);
		 
		 // 알림
		 List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());

		 int start = (page - 1) * size + 1; 
		 int totalPosts = companyMapper.getmainTotalPost();
		 int totalPages = (int) Math.ceil((double) totalPosts / size);
		 
		 List<CompanyVo> postList = companyMapper.getmainPostList(start, size);
		 
		 List<CompanyVo> recommendList = companyMapper.recommendList(compname, start, size);
		 System.out.println("recommendList" + recommendList);


		   Map<String, Object> resultMap = new HashMap<>();
		   if (!recommendList.isEmpty()) {
		      // userinfo의 첫 번째 요소에서 필요한 정보 추출
		   for (int i = 0; i < recommendList.size(); i++) { 
		   CompanyVo user = recommendList.get(i);
		  
		      resultMap.put("compuser_id", companyVo.getUser_id());
		      resultMap.put("compname", companyVo.getCompname()); // compname을 가져오는 메서드가 필요합니다.
		      resultMap.put("post", user.getPost_id()); // 
		      resultMap.put("user_id",  companyVo.getUser_id());
		      resultMap.put("username", user.getUsername());
		      resultMap.put("email", companyVo.getEmail());
		    
		       System.out.println(resultMap);
		      if(resultMap !=null) {
		       
		       String dupmessage = companyMapper.checkdupmes(resultMap);
		      
		       if (dupmessage == null) {
		        companyMapper.sendAIMassege(resultMap);// 현재 날짜로 설정
		            }       
		         }
		     } 
		  }
		  
		 model.addAttribute("postList", postList);
		 model.addAttribute("totalPages", totalPages);
		 model.addAttribute("currentPage", page);
		 model.addAttribute("messagelist", messagelist);
		 model.addAttribute("user_id", user_id); 
		 model.addAttribute("compname", compname); 
		 return "/company/main"; 
	 }
	//-------------------------------메인화면 검색 기능-----------------------//
		 
		 @RequestMapping("/SearchCheck")
		   @ResponseBody
		     public Map<String,Object> searchcheck(
		    		 @RequestParam(required = false, value="searchtext") String searchtext){
			 
			 System.out.println("searchtext : "+searchtext);
			 List<CompanyVo> searchlist = companyMapper.getSearchtextList(searchtext);
			 System.out.println("searchlist : "+searchlist);
			 Map<String, Object> response = new HashMap<>();
			 System.out.println("response : " + response);
			 response.put("searchlist", searchlist);
			 return response;
		 }
	
	// ------------------------------- 회원가입 -------------------------------//		   
    // Company/Signup (회원가입)
    @RequestMapping("/Signup")
    public ModelAndView signup() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/company/signup");
        return mv;
    }
    // Company/SignupForm (회원가입)
    @RequestMapping("/SignupForm")
    public ModelAndView signupForm(CompanyVo companyVo) {
    	companyMapper.signup(companyVo);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Company/Login"); 
        return mv;
        
    // ------------------------------- 기업등록 -------------------------------//		
    }
    // Company/CompanySignup (기업등록)
    @RequestMapping("/CompanySignup")
    public ModelAndView companysignup() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/company/companysignup");
        return mv;
    }
 // Company/CompanySignupForm (기업등록)
    @PostMapping("/CompanySignupForm")
    public ModelAndView companysignupForm(
            @RequestParam("logo") MultipartFile logo,
            CompanyVo companyVo) {

        // 프로젝트의 실제 경로
        String img = "D:\\dev_2\\spring\\TeamProject\\src\\main\\resources\\static\\img"; 

        // 파일 저장 경로 
        String filePath = img + "/" + logo.getOriginalFilename();

        try {
            // 디렉토리가 존재하지 않으면 생성
            File directory = new File(img);
            if (!directory.exists()) {
                directory.mkdirs(); // 디렉토리 생성
            }

            // 파일 저장
            logo.transferTo(new File(filePath));

            // 웹에서 접근할 수 있는 로고 경로 설정
            companyVo.setLogoPath("/img/" + logo.getOriginalFilename()); // DB에 저장할 경로 설정
            		// 동기 수정됨 vo 추가 하면됨 setlogopath 오류나면 불러주세요
            // 데이터베이스에 기업 정보 저장
            companyMapper.companysignup(companyVo);

        } catch (Exception e) {
            e.printStackTrace();
            // 파일 저장 실패 시 처리 로직 추가
        }

        ModelAndView mv = new ModelAndView();
        System.out.println("Address: " + companyVo.getAddress());
        mv.setViewName("redirect:/Company/Signup");
        return mv;
    }
    
	// 아이디 중복확인
    @RequestMapping(
    		value   = "/IdDupCheck",
    		method  = RequestMethod.GET,
    		headers = "Accept=application/json" )  
    	@ResponseBody                           
    	public  CompanyVo   idDupCheck(String user_id) {
    		String  result = "";  
    		CompanyVo  companyVo = companyMapper.idDupCheck( user_id  );		
    		return  companyVo;
    	}
    // 기업 중복확인
    @RequestMapping(
    		value   = "/CompDupCheck",
    		method  = RequestMethod.GET,
    		headers = "Accept=application/json" )  
    @ResponseBody                           
    public  CompanyVo   compDupCheck(String compname) {
    	String  result = "";
    	CompanyVo  compnameVo = companyMapper.compDupCheck( compname  );
    	System.out.println("컴퍼니:" + compnameVo);
    	return  compnameVo;
    } 
    
 // 이메일 중복방지  // 수정됨
    @RequestMapping(
           value = "/EmailDupCheck",
           method = RequestMethod.GET,
           headers = "Accept=application/json")
    @ResponseBody
    public CompanyVo emailDupCheck(String email , String originalEmail) {
       if (email.equals(originalEmail)) {
            return null;
        }
        CompanyVo compemailVo = companyMapper.emailDupCheck(email);
        System.out.println(compemailVo);
        return compemailVo;
       }
    
    // ------------------------------- 마이페이지 -------------------------------//
	// Company/Mypage (마이페이지)
    // http://localhost:9090/Company/Mypage?user_id=user1 
	@RequestMapping("/Mypage")
	public String mypage(CompanyVo companyVo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		CompanyVo login = (CompanyVo) session.getAttribute("login");
		
		List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
	
		String userid = login.getUser_id();
		CompanyVo vo = companyMapper.getUserById(userid);		
		
		model.addAttribute("vo", vo);
		model.addAttribute("messagelist", messagelist);
		return "company/mypage";
	}
	
	// Company/UpdateForm (마이페이지 수정)
	// http://localhost:9090/Company/UpdateForm?user_id=user1 
	@RequestMapping("/UpdateForm")
	public String updateForm(CompanyVo companyVo, Model model) {
		// 수정할 자료 조회
		CompanyVo vo = companyMapper.getUserById(companyVo.getUser_id());	
		model.addAttribute("vo", vo);
		
		return "company/update";
	}
	// Company/Update (마이페이지 수정)
	@RequestMapping("/Update")
	public String update(CompanyVo companyVo) {
		// 수정하기
		companyMapper.update(companyVo);
		String user_id = companyVo.getUser_id();
		// 수정 후 목록조회
		return "redirect:/Company/Mypage?user_id=" + user_id;
	}
	// Company/Delete (마이페이지_회원탈퇴)
	@RequestMapping("/Delete")
	public String delete(CompanyVo companyVo, RedirectAttributes redirectAttributes) {
		System.out.println("companyVo는" + companyVo );
		companyMapper.delete(companyVo);
		String user_id = companyVo.getUser_id();
		redirectAttributes.addFlashAttribute("message", "회원탈퇴가 완료되었습니다.");
		return "redirect:/Company/Login";
	}	
	
    // ------------------------------- 채용공고 -------------------------------//
	//Company/Postlist (채용공고 목록)
	@RequestMapping("/Postlistfilter")
    public ModelAndView Postlistfilter(
          @RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(required = false) String sort,
            @RequestParam String user_id,
            String compname,
            CompanyVo companyVo
            ) {
       int start = (page - 1) * size;
       int totalPosts = companyMapper.getreTotalPost(); 
       int totalPages = (int) Math.ceil((double) totalPosts / size); 
       
        List<CompanyVo> mainList = companyMapper.getrePostList(start,size,sort);
        System.out.println("mainList: " + mainList);
        
        // 알림
        List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
        
        ModelAndView mv = new ModelAndView();
        mv.addObject("mainList", mainList);
        mv.addObject("messagelist", messagelist);
        mv.addObject("totalPages", totalPages);
        mv.addObject("currentPage", page);
        mv.addObject("user_id", user_id);
        mv.addObject("compname", compname);
        mv.setViewName("company/postlistfilter");
        return mv;
    }
    //---------------------------------------------------------------------
    @RequestMapping("/Postlistsort")
    public ModelAndView Postlistsort(
          @RequestParam(defaultValue = "1") int page, 
          @RequestParam(defaultValue = "5") int size,
          @RequestParam(required = false) String sort,
          @RequestParam String user_id,
          String compname,
          CompanyVo companyVo
          ) {
       int start = (page - 1) * size;
       int totalPosts = companyMapper.getreTotalPost(); 
       int totalPages = (int) Math.ceil((double) totalPosts / size); 
       
       List<CompanyVo> mainList = companyMapper.getrePostList(start,size,sort);
       System.out.println("mainList: " + mainList);
       
       // 알림
       List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
       
       ModelAndView mv = new ModelAndView();
       mv.addObject("mainList", mainList);
       mv.addObject("messagelist", messagelist);
       mv.addObject("totalPages", totalPages);
       mv.addObject("currentPage", page);
       mv.addObject("user_id", user_id);
       mv.addObject("compname", compname);
       mv.addObject("selectedSort", sort);
       mv.setViewName("company/postlistsort");
       return mv;
    }

		//------------------------ 채용공고 리스트 정렬 -------------------------------------//
		
		@RequestMapping("/SelectCheck")
		@ResponseBody
		public Map<String, Object> selectCheck(
		        @RequestParam(required = false, value="selectvalue") String selectvalue,
		        @RequestParam(required = false, value="career") String career,
		        @RequestParam(required = false, value="department") String department,
		        @RequestParam(required = false, value="workspace") String workspace,
		        @RequestParam(required = false, value="edu") String edu,
		        @RequestParam(defaultValue = "1") int page, 
		        @RequestParam(defaultValue = "5") int size
		) {
		    System.out.println("department : " + department);

		    Map<String, Object> response = new HashMap<>();

		    int start = (page - 1) * size;

		    // 정렬 리스트
		    List<CompanyVo> sortlist = null; // 초기화
		       if ("firsts".equals(selectvalue)) {
		           sortlist = companyMapper.getpostlistSortfirsts(start, size); // 첫 번째 경우
		       } else if ("laters".equals(selectvalue)) {
		           sortlist = companyMapper.getpostlistSortLast(start, size); // 두 번째 경우
		       } else if ("counts".equals(selectvalue)) {
		           sortlist = companyMapper.getpostlistSortCount(start, size); // 세 번째 경우
		       } else if ("".equals(selectvalue)) {
		          sortlist = companyMapper.getmainList(start, size); // 세 번째 경우
		       } else {
		           // 기본 처리 또는 에러 처리
		           response.put("error", "유효하지 않은 selectvalue입니다.");
		           return response;
		       }

		    // 경력에 따른 매칭 리스트
		    List<CompanyVo> matchlist = null;
		    matchlist = companyMapper.getMatching(career,department,workspace,edu);

		    int totalPosts = companyMapper.getreTotalPost(); 
		    int totalPages = (int) Math.ceil((double) totalPosts / size); 

		    System.out.println("sortList: " + sortlist);
		    response.put("sortlist", sortlist);
		    response.put("matchlist", matchlist);
		    response.put("totalPages", totalPages);
		    response.put("currentPage", page);
		    System.out.println("response: " + response);
		    
		    return response;
		}             
	    
	//-----------------------채용공고 상세페이지------------------------------------//
	//Company/Postview (채용공고 상세페이지)
	// http://localhost:9090/Company/View?aplnum=1
		// Company/Postview (채용공고 상세페이지)
		// http://localhost:9090/Company/View?aplnum=1
		@RequestMapping("/Postview")
		public ModelAndView postview(CompanyVo companyVo, String user_id) {
		    
		    // 조회수 증가
		    companyMapper.plushit(companyVo);
		    
		    // 글 조회
		    CompanyVo vo = companyMapper.getmain(companyVo);
		    System.out.println("vo: " + vo);
		    
		    // 기업정보 조회
		    String compname = vo.getCompname();
		    CompanyVo comp = companyMapper.getcomp(compname);
		    System.out.println("comp: " + comp);
		    
		    // 담당자정보 조회
		    String userId = vo.getUser_id();
		    CompanyVo user = companyMapper.getuser(userId);
		    System.out.println("user: " + user);

		    // 기업의 평균 평점과 총 리뷰 수 조회
		    double averageRating = companyMapper.getCompanyAverage(compname);
		    int totalReviews = companyReviewsMapper.getTotalReviewsCount(compname);

		    // 줄바꿈 처리
		    String duty = vo.getDuty().replace("\n", "<br>");
		    vo.setDuty(duty);
		    
		    ModelAndView mv = new ModelAndView();
		    mv.addObject("vo", vo);
		    mv.addObject("comp", comp);
		    mv.addObject("user", user);
		    mv.addObject("user_id", user_id);
		    mv.addObject("averageRating", averageRating); // 평균 평점 추가
		    mv.addObject("totalReviews", totalReviews);   // 총 리뷰 수 추가
		    mv.setViewName("company/postview");
		    return mv;
		}

	
	//----------------------채용공고 등록---------------------------------------------------
	//Company/WriteForm (채용공고 등록)
	// http://localhost:9090/Company/WriteForm?aplnum=1
	
	@RequestMapping("/WriteForm")
	public ModelAndView writeform(CompanyVo companyVo, String user_id, String compname) {
		
		ModelAndView mv = new ModelAndView();
		System.out.println("writeformVo"+companyVo);
		mv.addObject("companyVo", companyVo);
		mv.addObject("user_id", user_id);
		mv.addObject("compname", compname);
		mv.setViewName("company/postwrite");
		return mv;
	}
	
	@RequestMapping("/Postwrite")
	public ModelAndView postwrite(CompanyVo companyVo, String user_id, String compname) {
		// System.out.println("Received deadline: " + companyVo.getDeadline());
	    companyMapper.insertposting(companyVo);
	    // System.out.println("writeVo"+companyVo);
	    
	    ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("compname", compname);
		mv.setViewName("redirect:/Company/ListManagement");
		return mv;
	}
	
	//--------------------------채용공고 삭제-------------------------------------------
	// /Company/Postdelete (채용공고 삭제)
	// http://localhost:9090/Company/Postdelete?&aplnum=11
	@RequestMapping("/Postdelete")
	public ModelAndView postdelete(CompanyVo companyVo,String user_id, String compname) {
		
		companyMapper.deleteposting(companyVo);
		System.out.println("delete"+companyVo);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("compname", compname);
		mv.setViewName("redirect:/Company/ListManagement");
//		mv.setViewName("redirect:/Company/ListManagement");
		return mv;
	}
	
	//-----------------------------채용공고 수정-------------------------------------------------
	// /Company/PostupdateForm (채용공고 수정)
	//http://localhost:9090/Company/PostupdateForm?&aplnum=8
	@RequestMapping("/PostupdateForm")
	public ModelAndView postupdateForm(CompanyVo companyVo,String user_id, String compname) {
		
		ModelAndView mv = new ModelAndView();
		CompanyVo vo = companyMapper.getmain(companyVo);
		System.out.println("postupdateForm"+vo);
		
		mv.addObject("vo", vo);
		mv.addObject("user_id", user_id);
		mv.addObject("compname", compname);
		mv.setViewName("company/postupdate");
		return mv;
	}
	
	@RequestMapping("/Postupdate")
	public ModelAndView postupdate(CompanyVo companyVo, String user_id, String compname) {
		
		System.out.println("Postupdate:"+companyVo);
		
		companyMapper.updateposting(companyVo);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("compname", compname);
		mv.setViewName("redirect:/Company/Postlistfilter");
		return mv;
	}
	
	// ---------------------------- 등록공고목록 ----------------------------//
	// http://localhost:9090/Company/ListManagement
	// 기업별 등록 공고리스트
	@RequestMapping("/ListManagement")
	public ModelAndView listmanagment(
			@RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "5") int size,
            @RequestParam String user_id, 
            String compname,
            CompanyVo companyVo
			) { 
		int start = (page - 1) * size; 
		int totalPosts = companyMapper.getTotalCpost(compname);
		int totalPages = (int) Math.ceil((double) totalPosts / size);
		
		List<CompanyVo> CompanyList = companyMapper.getCompanyList(compname,start, size);
		
		//알림
		List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("CompanyList",CompanyList);
		mv.addObject("messagelist",messagelist);
		mv.addObject("totalPages", totalPages);
		mv.addObject("currentPage", page);
		mv.addObject("user_id", user_id);
		mv.addObject("compname", compname);
		mv.setViewName("company/listmanagement");
		return mv;
		}
	
	//------------------------등록공고에서 새로운 공고-----------------------// 
		@RequestMapping("/WriteForm2")
		public ModelAndView writeform2(CompanyVo companyVo, String user_id, String compname) {
			
			ModelAndView mv = new ModelAndView();
			System.out.println("writeformVo"+companyVo);
			mv.addObject("companyVo", companyVo);
			mv.addObject("user_id", user_id);
			mv.setViewName("/company/postwrite2");
			return mv;
		}
		
		@RequestMapping("/Postwrite2")
		public ModelAndView postwrite2(CompanyVo companyVo, String user_id, String compname) {
			
			companyMapper.insertposting(companyVo);
			
			System.out.println("writeVo"+companyVo);
			ModelAndView mv = new ModelAndView();
			mv.addObject("user_id", user_id);
			mv.addObject("compname", compname);
			mv.addObject("companyVo", companyVo);
			mv.setViewName("redirect:/Company/ListManagement");
			return mv;
		}
		
		//-----------------------등록공고에서 삭제------------------------------
		@RequestMapping("/Postdelete2")
		public ModelAndView postdelete2(CompanyVo companyVo,String user_id, String compname) {
			
			companyMapper.deleteposting(companyVo);
			System.out.println("delete"+companyVo);
			
			ModelAndView mv = new ModelAndView();
			mv.addObject("user_id", user_id);
			mv.addObject("compname", compname);
			mv.addObject("companyVo", companyVo);
			mv.setViewName("redirect:/Company/ListManagement");
			return mv;
		}
		
		
		//---------------------------등록공고에서 상세보기----------------------------------------
		@RequestMapping("/Postview2")
		public ModelAndView postview2(CompanyVo companyVo,String user_id, String compname) {
			
			//조회수 증가
			companyMapper.plushit(companyVo);
			System.out.println("plusint"+companyVo);
			
			//글 조회
			CompanyVo vo = companyMapper.getmain(companyVo);
			//System.out.println("vo"+vo);
			
			//기업정보 조회
			CompanyVo comp = companyMapper.getcomp(compname);
			System.out.println("comp"+comp);
			
			//담당자정보 조회
			CompanyVo user = companyMapper.getuser(user_id);
			System.out.println("user"+user);
			String       duty   =  vo.getDuty().replace("\n", "<br>");
			vo.setDuty( duty );
			
			ModelAndView mv = new ModelAndView();
			mv.addObject("vo",vo );
			mv.addObject("user_id", user_id);
			mv.addObject("comp", comp);
			mv.addObject("user", user);
			mv.addObject("companyVo", companyVo);
			mv.setViewName("company/postview2");
			return mv;
		}
		
		
		//--------------------------------등록공고에서 수정
		@RequestMapping("/PostupdateForm2")
		public ModelAndView postupdateForm2(CompanyVo companyVo,String user_id, String compname) {
			
			ModelAndView mv = new ModelAndView();
			CompanyVo vo = companyMapper.getmain(companyVo);
			System.out.println("postupdateForm"+vo);
			
			mv.addObject("vo", vo);
			mv.addObject("user_id", user_id);
			mv.addObject("compname", compname);
			mv.addObject("companyVo", companyVo);
			mv.setViewName("company/postupdate2");
			return mv;
		}
		
		@RequestMapping("/Postupdate2")
		public ModelAndView postupdate2(CompanyVo companyVo,String user_id, String compname) {
			
			System.out.println("Postupdate"+companyVo);
			
			companyMapper.updateposting(companyVo);
			
			ModelAndView mv = new ModelAndView();
			mv.addObject("user_id", user_id);
			mv.addObject("compname", compname);
			mv.addObject("companyVo", companyVo);
			mv.setViewName("redirect:/Company/ListManagement");
			return mv;
		}
	
    // ------------------------------- 이력서 -------------------------------//
	
		//Company/ResumeList (이력서 목록)
		   @RequestMapping("/ResumeList")
		   public ModelAndView resumeList(
		         @RequestParam(defaultValue = "1") int page, 
		            @RequestParam(defaultValue = "5") int size,
		            @RequestParam String user_id, 
		            @RequestParam String compname, 
		         CompanyVo companyVo,
		         IndividualVo individualVo
		         ) {
		       
		      int start = (page - 1) * size;
		      int totalPosts = companyMapper.getResumeCount(compname);
		      int totalPages = (int) Math.ceil((double) totalPosts / size);
		       
		       // user_id로 postIds들 불러오기
		      List<String> postIds = companyMapper.getPostIdsByUserId(user_id, compname, start, size);
		       System.out.println("Retrieved postIds: " + postIds);

		       // postIds로 지원서(compname)불러오기
		       List<IndividualVo> appList = companyMapper.getApplicationsByPostIds(postIds);
		       System.out.println("Retrieved app list: " + appList);
		       
		       
		       // postId로 지원서 불러오기
		       List<IndividualVo> resumeList = new ArrayList<>();
		       for (IndividualVo application : appList) {
		          resumeList.addAll(companyMapper.getResumeListByPostId(application.getPost_id()));
		          }
		       
		       System.out.println("Retrieved resumeList: " + resumeList);
		  //-----------------------------------------------------------------------------------------------------------    
		    // 점수 계산용
		       List<CompanyVo> scoreList = companyMapper.getScoreList(compname);
		       System.out.println("scoreList: " + scoreList);

		       // skills1과 licenses1의 값에서 , 기준으로 분리하여 리스트로 변환
		       List<List<String>> skillsList = new ArrayList<>();
		       List<List<String>> licensesList = new ArrayList<>();

		       for (int i = 0; i < resumeList.size(); i++) {
		           IndividualVo resume = resumeList.get(i);
		           
		           String skills1 = resume.getSkills1(); // skills1 값 가져오기
		           if (skills1 != null && !skills1.trim().isEmpty()) {
		               List<String> skills = Arrays.asList(skills1.split(",")); // 쉼표로 분리
		               skillsList.add(skills); // 리스트에 추가
		           } else {
		               skillsList.add(new ArrayList<>()); // skills1이 없으면 빈 리스트 추가
		           }
		           
		           String licenses1 = resume.getLicenses(); // licenses1 값 가져오기
		           if (licenses1 != null && !licenses1.trim().isEmpty()) {
		               List<String> licenses = Arrays.asList(licenses1.split(",")); // 쉼표로 분리
		               licensesList.add(licenses); // 리스트에 추가
		           } else {
		               licensesList.add(new ArrayList<>()); // licenses1이 없으면 빈 리스트 추가
		           }
		       }

		       System.out.println("Skills List: " + skillsList);
		       System.out.println("Licenses List: " + licensesList);

		       List<Integer> totalScoreList = new ArrayList<>();
		       List<Integer> hopescoreList = new ArrayList<>(); // 희망 점수를 저장할 리스트

		       for (int i = 0; i < resumeList.size(); i++) {
		           IndividualVo individual = resumeList.get(i);
		           
		           // skillsList의 해당 인덱스에서 기술 목록 가져오기
		           List<String> individualSkills = skillsList.get(i);
		           System.out.println("Skills for Resume " + (i + 1) + ": " + individualSkills);
		           
		           // licensesList의 해당 인덱스에서 자격증 목록 가져오기
		           List<String> individualLicenses = licensesList.get(i);
		           System.out.println("Licenses for Resume " + (i + 1) + ": " + individualLicenses);
		           
		           // 교육 및 경력 정보 가져오기
		           String edu = individual.getEdu();
		           String career = individual.getCareer();
		           System.out.println("edu: " + edu);
		           System.out.println("career: " + career);
		           
		           // scoreList의 각 CompanyVo 객체에 대해 반복
		           if (i < scoreList.size()) { // scoreList의 크기 체크
		               CompanyVo company = scoreList.get(i);
		               
		               List<String> companySkills = new ArrayList<>();
		               List<String> companyLicenses = new ArrayList<>();

		               String skills1 = company.getSkills(); // skills1 값 가져오기
		               if (skills1 != null && !skills1.trim().isEmpty()) {
		                   companySkills = Arrays.asList(skills1.split(",")); // 쉼표로 분리
		               }
		               
		               String licenses1 = company.getLicenses(); 
		               if (licenses1 != null && !licenses1.trim().isEmpty()) {
		                   companyLicenses = Arrays.asList(licenses1.split(",")); // 쉼표로 분리
		               }
		               
		               String educompany = company.getEdu();
		               String careercompany = company.getCareer();
		               System.out.println("educompany: " + educompany);
		               System.out.println("careercompany: " + careercompany);

		               System.out.println("Skills List2: " + companySkills);
		               System.out.println("Licenses List2: " + companyLicenses);
		               
		               // CompanyVo 객체에서 희망 점수 가져오기
		               int hopescore = company.getHopescore(); 
		               hopescoreList.add(hopescore); 
		               
		               int skillsscore = company.getSkillsscore(); 
		               int licensesScore = company.getLicensesscore(); // 자격증 점수
		               int careerscore = company.getCareerscore(); // 경력 점수
		               int eduscore = company.getEduscore(); // 교육 점수
		               System.out.println("skillsscore : " + skillsscore);
		               System.out.println("licensesScore : " + licensesScore);
		               System.out.println("careerscore : " + careerscore);
		               System.out.println("eduscore : " + eduscore);
		               
		               // 기술 개수 비교하여 totalScore 계산
		               long commonSkillsCount = individualSkills.stream()
		                   .filter(companySkills::contains) // individualSkills에서 companySkills에 포함된 항목 필터링
		                   .count(); // 개수 세기
		               
		               // 자격증 개수 비교하여 totalLicensesCount 계산
		               long commonLicensesCount = individualLicenses.stream()
		                   .filter(companyLicenses::contains) // individualLicenses에서 companyLicenses에 포함된 항목 필터링
		                   .count(); // 개수 세기
		               
		               // totalScore 계산 (공통 기술 개수 * skillsscore + 공통 자격증 개수 * licensesScore)
		               int totalScore = (int) commonSkillsCount * skillsscore + (int) commonLicensesCount * licensesScore;
		               
		               // 교육 및 경력 비교하여 총 점수 추가
		               if (edu != null && edu.equals(educompany)) {
		                   totalScore += eduscore; // 교육이 일치할 경우 eduscore 추가
		               }
		               if (career != null && career.equals(careercompany)) {
		                   totalScore += careerscore; // 경력이 일치할 경우 careerscore 추가
		               }
		               
		               // 결과를 새로운 리스트에 추가
		               totalScoreList.add(totalScore);
		           }
		       }

		       System.out.println("Total Score List: " + totalScoreList);

		       List<String> resultList = new ArrayList<>();

		       // scoreList의 각 CompanyVo 객체에 대해 반복
		       for (int i = 0; i < scoreList.size(); i++) {
		           CompanyVo company = scoreList.get(i);
		           
		           // CompanyVo 객체에서 hopescore 가져오기
		           int hopescore = company.getHopescore();
		           System.out.println("hopescore : " + hopescore);
		           
		           // totalScoreList에서 해당 인덱스의 총 점수 가져오기
		           int totalScore = totalScoreList.get(i);
		           
		           // totalScore와 hopescore 비교
		           String result = (totalScore >= hopescore) ? "합격" : "불합격";
		           
		           // 결과 리스트에 추가
		           resultList.add(result);
		           
		       }

		       // 최종 결과 출력 (디버깅용)
		       System.out.println("합격 여부: " + resultList);
		        
		       
		       
		       // 알림
		       List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
		       
		       ModelAndView mv = new ModelAndView();
		       mv.addObject("appList", appList);
		       mv.addObject("resumeList", resumeList);
		       mv.addObject("messagelist", messagelist);
		       mv.addObject("totalPages", totalPages);
		       mv.addObject("currentPage", page);
		       mv.addObject("user_id", user_id);
		       mv.addObject("compname", compname);
		       mv.addObject("resultList", resultList);
		       mv.addObject("hopescoreList", hopescoreList); // 희망 점수 리스트 추가
		       mv.addObject("totalScoreList", totalScoreList); // 실제 점수 리스트 추가
		       mv.setViewName("company/resumeList");
		       return mv;
		   }
	
	//Company/Resumeview (이력서 상세페이지)
	// http://localhost:9090/Company/Resumview?title=usera이력서
	@RequestMapping("/Resumeview")
	public ModelAndView resumeview(IndividualVo individualVo, String title, String post_id, String user_id) {				
		//이력서 조회
		IndividualVo vo = companyMapper.getresumeList(individualVo);
		System.out.println("vo"+vo);
		System.out.println("post_id"+post_id);
		
		// System.out.println("Title without spaces: " + title);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo", vo);
		mv.addObject("title", title);
		mv.addObject("post_id", post_id);
		mv.addObject("user_id", user_id);
		mv.setViewName("company/resumeview");
		return mv;
	}
	// 이력서 결과 수정
	@RequestMapping(value = "/updateresume", method = RequestMethod.GET)
	public String updateresume(String title, String result, String post_id, String user_id, String compname) {
	    System.out.println("title=" + title);
	    System.out.println("result=" + result);
	    System.out.println("post_id=" + post_id);
	    System.out.println("user_id=" + user_id);
	    System.out.println("compname=" + compname);
	    
	    // 이력서 결과 업데이트
	    companyMapper.updateresume(title, result, post_id);
	    
	    List<CompanyVo> resumeresultInfo = companyMapper.getApplicationformessage(post_id);
	    System.out.println("이력서 업데이트후조회:" + resumeresultInfo);
	    
	    HashMap<String, Object> resultMap = new HashMap<>();
	    resultMap.put("post_id", post_id);
	    resultMap.put("compuser_id", user_id);
	    resultMap.put("compname", compname);
	    resultMap.put("updated_result", result);

	    if (!resumeresultInfo.isEmpty()) {
	        CompanyVo resultinfo = resumeresultInfo.get(0);
	        resultMap.put("user_id", resultinfo.getUser_id()); 
	        resultMap.put("post_id", resultinfo.getPost_id()); 
	    
	        
	    System.out.println("결과 HashMap: " + resultMap);
	    companyMapper.sendresumeresultMassege(resultMap);
	  }
	    
	    String user_id2 = "user1";
	    String compname2 = "%EB%84%A4%EC%9D%B4%EB%B2%84";
	    
	    // user_id와 compname을 포함한 리다이렉트

	        return "redirect:/Company/ResumeList?user_id=" + user_id2 + "&compname=" + compname2;
	    } 
	    
	
	//이력서 상세보기(보는것만)
	
	@RequestMapping("/Resumejustview")
	public ModelAndView resumejustview(IndividualVo individualVo, String title, String user_id) {				
		//이력서 조회
		IndividualVo vo = companyMapper.getresumeList(individualVo);
		System.out.println("vo"+vo);
		
		// System.out.println("Title without spaces: " + title);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo", vo);
		mv.addObject("title", title);
		mv.addObject("user_id", user_id);
		mv.setViewName("company/resumejustview");
		return mv;
	
	}
	
	// ------------------------------- 인재 추천 -------------------------------//
	// http://localhost:9090/Company/Recommend?user_id=user3&compname=카카오
	//인재 추천
	@RequestMapping("/Recommend")
	public ModelAndView recommend(
			@RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "5") int size,
            @RequestParam String user_id,
            String compname,
			CompanyVo companyVo 
			) {
		
		int start = (page - 1) * size;
		int totalPosts = companyMapper.getTotalRecommend(user_id, compname);
		int totalPages = (int) Math.ceil((double) totalPosts / size);
		
		List<CompanyVo> recommendList = companyMapper.recommendList(compname, start, size);
		System.out.println("recommendList"+recommendList);
		ModelAndView mv = new ModelAndView();
		
		// 알림
		List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
				
		// user_id 가져오기
		String userID = companyVo.getUser_id();
	    List<CompanyVo> JJIMLIST = companyMapper.JJIMList(userID);
	    System.out.println("찜목록:"+ JJIMLIST);

		//북마크 가져오기
		 List<String> scrapStatuses = new ArrayList<>();
		  for (CompanyVo recommended : recommendList) {
		        String title = recommended.getTitle(); // 추천 목록에서 제목 가져오기
		        String username = recommended.getUsername();
		        System.out.println("이름들:"+username);
		        if (title != null) {
		            title = title.trim(); // 제목의 공백 제거
		        }
		 
		 Map<String,String> scrapIds = new HashMap<>();
		      scrapIds.put("username",username); //recommendList 안 에있음 
		      scrapIds.put("user_id",userID);  // companyVo 에 있음 
		      scrapIds.put("title",title);   //recommendList 안에있음 
	
		      String scrapStatus = title != null ? companyMapper.JJIMLSTAT(scrapIds) : null;
		         if (scrapStatus != null) {
		             if ("ON".equals(scrapStatus)) {
		                 scrapStatuses.add("red"); // ON일 경우 yellow
		             } else {
		                 scrapStatuses.add("none"); // OFF일 경우 none
		             }
		         } else {
		             scrapStatuses.add("none"); // NULL로 저장
		         }
		   }
		         
		mv.addObject("recommendList", recommendList);
		mv.addObject("messagelist", messagelist);
		mv.addObject("scrapStatus", scrapStatuses);
		mv.addObject("JJIMLIST", JJIMLIST);
		System.out.println(scrapStatuses);
		mv.addObject("totalPages", totalPages);
		mv.addObject("currentPage", page);
		mv.addObject("user_id", userID);
	    mv.addObject("compname", compname);
		mv.setViewName("company/recommend");
		return mv;
	}
	
	//-----------------------------------북마크--------------------------------------//
	//http://localhost:9090/Company/Bookmark?user_id=user3&compname=%EC%82%BC%EC%84%B1
	@RequestMapping("/MarkList")
	public ModelAndView marklist(
			@RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "5") int size,
            @RequestParam String user_id,
            String compname,
			CompanyVo companyVo 
			) {
		int start = (page - 1) * size;
		int totalPosts = companyMapper.getTotalRecommend(user_id, compname);
		int totalPages = (int) Math.ceil((double) totalPosts / size);
		
		List<CompanyVo> recommendList = companyMapper.recommendList(compname, start, size);
		System.out.println("recommendList"+recommendList);
		
		//알림
		List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
		ModelAndView mv = new ModelAndView();
		
		// user_id 가져오기
		String userID = companyVo.getUser_id();
	    List<CompanyVo> JJIMLIST = companyMapper.JJIMList(userID);
	    System.out.println("찜목록:"+ JJIMLIST);

		//북마크 가져오기
		 List<String> scrapStatuses = new ArrayList<>();
		  for (CompanyVo recommended : recommendList) {
		        String title = recommended.getTitle(); // 추천 목록에서 제목 가져오기
		        String username = recommended.getUsername();
		        System.out.println("이름들:"+username);
		        if (title != null) {
		            title = title.trim(); // 제목의 공백 제거
		        }
		 
		 Map<String,String> scrapIds = new HashMap<>();
		      scrapIds.put("username",username); //recommendList 안 에있음 
		      scrapIds.put("user_id",userID);  // companyVo 에 있음 
		      scrapIds.put("title",title);   //recommendList 안에있음 
	
		      String scrapStatus = title != null ? companyMapper.JJIMLSTAT(scrapIds) : null;
		         if (scrapStatus != null) {
		             if ("ON".equals(scrapStatus)) {
		                 scrapStatuses.add("red"); // ON일 경우 yellow
		             } else {
		                 scrapStatuses.add("none"); // OFF일 경우 none
		             }
		         } else {
		             scrapStatuses.add("none"); // NULL로 저장
		         }
		   }
		         
		mv.addObject("recommendList", recommendList);
		mv.addObject("scrapStatus", scrapStatuses);
		
		mv.addObject("messagelist", messagelist);
		mv.addObject("JJIMLIST", JJIMLIST);
		System.out.println(scrapStatuses);
		mv.addObject("totalPages", totalPages);
		mv.addObject("currentPage", page);
		mv.addObject("user_id", userID);
	    mv.addObject("compname", compname);
		mv.setViewName("company/marklist");
		return mv;
	}
	//-----------------------------------픽미--------------------------------------//	
	//http://localhost:9090/Company/Bookmark?user_id=user3&compname=%EC%82%BC%EC%84%B1
	
	//북마크기능 
	@SuppressWarnings("null")
	@RequestMapping(value = "/Bookmarking", method = RequestMethod.POST)
	public String bookmarking(CompanyVo companyVo,  String user_id,  String username,  RedirectAttributes redirectAttributes )throws UnsupportedEncodingException {
			
	    String userId = companyVo.getUser_id(); // user_id 가져오기
		String title = companyVo.getTitle(); // title 가져오기
        String Compname = companyVo.getCompname();
        String phone_number = companyVo.getPhone_number();
        String inusername =companyVo.getUsername();
		
        System.out.println(Compname);
    	List<CompanyVo> existingBookmark = companyMapper.getBookmark(userId, title, Compname);
    	List<CompanyVo> userinfo = companyMapper.getUserinfo(inusername, title, phone_number); //24.11.13
    	System.out.println("가져온 유저 정보:"+userinfo);
    	
    	//24.11.13 메세지 보내기
        Map<String, Object> resultMap = new HashMap<>();
            if (!userinfo.isEmpty()) {
                // userinfo의 첫 번째 요소에서 필요한 정보 추출
                CompanyVo user = userinfo.get(0);
                
                resultMap.put("compuser_id", companyVo.getUser_id());
                resultMap.put("compname", companyVo.getCompname());
                resultMap.put("user_id", user.getUser_id());
                resultMap.put("username", user.getUsername());
                resultMap.put("email", user.getEmail());
               
            }
			
		ModelAndView mv = new ModelAndView();
		String alertMessage = "";	
		
			if (existingBookmark != null && !existingBookmark.isEmpty()) {
		    // 북마크가 존재할경우, 북마크 상태 변경 ON/OFF.
				String  isBookmarked =  companyMapper.isBookmark(userId, title);
				if ("ON".equals(isBookmarked)){
			        companyMapper.toggleBookmark(userId, title);  // DB의 BOOKMARK 값이 ON일경우 
			        alertMessage = "Pick! 취소 되었습니다.";
			        companyMapper.sendMassege2(resultMap); //24.11.13 취소 메세지 보내기
			         } else if ("OFF".equals(isBookmarked)){      // DB의 BOOKMARK 값이 OFF일경우 
			        companyMapper.toggleBookmark(userId, title);
			        alertMessage = "Pick! 하셨습니다.";
			        companyMapper.sendMassege(resultMap); //24.11.13 요청 메세지 보내기
			         }
		        	 System.out.println("북마크 상태를 토글했습니다: User ID = " + userId + ", Title = " + title);
					} else {
				
		    // 존재하지않는경우  
				companyMapper.saveBookmark(companyVo); // 북마크 저장(기본값 OFF)
				System.out.println("북마크 저장: " + companyVo);
				companyMapper.sendMassege(resultMap); //24.11.13 메세지 보내기
				 
				companyMapper.toggleBookmark(userId, title); // 북마크 값 변경(OFF -> ON)
				alertMessage = "Pick! 하셨습니다.";
				System.out.println("없는상태로 북마크 상태를 토글했습니다: User ID = " + userId + ", Title = " + title);	
		        }       
				
				List<CompanyVo> booklist = companyMapper.getBookmark(userId, title , Compname); // 북마크 목록 가져오기
				redirectAttributes.addFlashAttribute("alertMessage", alertMessage);
	             
				String encodedCompname = URLEncoder.encode(Compname, StandardCharsets.UTF_8.toString());

				    
				// 뷰에 데이터 추가(recommend가 맞음)
				mv.addObject("booklist", booklist);
				mv.addObject("alertMessage", alertMessage);
				
				return "redirect:/Company/Recommend?user_id=" + userId + "&compname=" + encodedCompname;

			}
	// 북마크(찜) 기능 11.14 
	@SuppressWarnings("null")
	@RequestMapping(value = "/BookmarkingJJ", method = RequestMethod.POST)
	public String bookmarkingjj(CompanyVo companyVo, String user_id, String username,
		RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {
	
		String userId = companyVo.getUser_id(); // user_id 가져오기
		String title = companyVo.getTitle().trim(); // title 가져오기
		String Compname = companyVo.getCompname();
		String phone_number = companyVo.getPhone_number();
		String inusername =companyVo.getUsername();

	    System.out.println("jjim:"+companyVo);
		System.out.println(Compname);
		System.out.println(userId);
		System.out.println(title);
		//아래 코드 북마크 말고 DB 찜 추가 하기
		List<CompanyVo> existingJJIM = companyMapper.getJJIM(userId,title);
		System.out.println("existingJJIM:"+existingJJIM);
	
		ModelAndView mv = new ModelAndView();
		String alertMessage = "";
	
		if (existingJJIM != null && !existingJJIM.isEmpty()) {
		// 북마크가 존재할경우, 북마크 상태 변경 ON/OFF.
		String isJJIM= companyMapper.isJJIM(userId,title);
		if ("ON".equals(isJJIM)) {
		companyMapper.toggleJJIM(userId, title); // DB의 BOOKMARK 값이 ON일경우
		//alertMessage = "찜! 취소 되었습니다."; 
	
	
		} else if ("OFF".equals(isJJIM)) { // DB의 BOOKMARK 값이 OFF일경우
		companyMapper.toggleJJIM(userId, title);
		//alertMessage = "찜! 하셨습니다.";
		}
		System.out.println("북마크 상태를 토글했습니다: User ID = " + userId + ", Title = " + title);
		} else {
	
		// 존재하지않는경우
		companyMapper.saveJJIM(companyVo); // 북마크 저장(기본값 OFF)
		System.out.println("북마크 저장: " +companyVo);
	
	
		companyMapper.toggleJJIM(userId, title); // 북마크 값 변경(OFF -> ON)
		//alertMessage = "찜! 하셨습니다.";
		System.out.println("없는상태로 찜 상태를 토글했습니다: User ID = " + userId + ", Title = " + title);
	
		}
	
		List<CompanyVo> JJIMLIST = companyMapper.getJJIM(userId, title ); // 북마크 목록 가져오기
		redirectAttributes.addFlashAttribute("alertMessage", alertMessage);
	
		String encodedCompname = URLEncoder.encode(Compname, StandardCharsets.UTF_8.toString());
	
		// 뷰에 데이터 추가
		mv.addObject("JJIMLIST", JJIMLIST);
		mv.addObject("alertMessage", alertMessage);
		
		return "redirect:/Company/Recommend?user_id=" + userId + "&compname=" + encodedCompname; 

	}
	//북마크확인
	@RequestMapping("Bookmark")
	public ModelAndView bookmark(
			CompanyVo companyVo,
			@RequestParam(defaultValue = "1") int page,
		    @RequestParam(defaultValue = "5") int size,
		    @RequestParam String user_id,
		    @RequestParam String compname,
			String username, 
			Model model
			) {
		int start = (page - 1) * size;
		int totalPosts = companyMapper.getTotalBookmark(user_id); 
		int totalPages = (int) Math.ceil((double) totalPosts / size);
		
		String title = companyVo.getTitle();
		
		List<CompanyVo> bookmarkList = companyMapper.bookmarkList(user_id, title, start, size);
		List<CompanyVo> JJIMList = companyMapper.JJIMList(user_id);
		System.out.println("bookmark"+bookmarkList);
		
		List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());
		System.out.println("message:"+messagelist);
		model.addAttribute( "messagelist", messagelist);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("bookmarkList", bookmarkList);
		mv.addObject("JJIMList", JJIMList);
		mv.addObject("totalPages", totalPages);
	    mv.addObject("currentPage", page);
	    mv.addObject("user_id", user_id);
	    mv.addObject("compname", compname);
		mv.setViewName("/company/bookmark");
		return mv;
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
	        CompanyVo companyVo
			) {
	    List<CompanyVo> faqList = companyMapper.getfaqList();
	    
	    int start = (page - 1) * size;
		int totalPosts = companyMapper.getTotalCs();
		int totalPages = (int) Math.ceil((double) totalPosts / size);

		List<CompanyVo> csList = companyMapper.getcsList(user_id,start, size);
	    System.out.println("csList=" + csList);
	    
	    // 알림
	    List<IndividualVo> messagelist = companyMapper.getMessages(companyVo.getUser_id());

	    ModelAndView mv = new ModelAndView();
	    mv.addObject("faqList", faqList);
	    mv.addObject("csList", csList);
	    mv.addObject("messagelist", messagelist);
	    mv.addObject("csp_id", csp_id);
	    mv.addObject("totalPages", totalPages);
	    mv.addObject("currentPage", page);
	    mv.addObject("user_id", user_id);
	    mv.addObject("compname", compname);
	    mv.setViewName("company/cslist");
	    return mv;
	}
	// Company/Csview (문의글 상세페이지)
	@RequestMapping("/Csview")
	public ModelAndView csview(CompanyVo companyVo, CommentVo commentVo, String user_id, Integer csp_id, String csp_title) {
		companyVo.setCspId(csp_id);
	    CompanyVo vo = companyMapper.getcs(companyVo); // 필요한 경우 수정 필요
	    System.out.println("vo1111=" + vo);
	    
	    // 댓글
	    List<CommentVo> commentList = commentMapper.commentList(csp_id);
    
	    ModelAndView mv = new ModelAndView();
	    mv.addObject("vo", vo);
	    mv.addObject("user_id", user_id);
	    mv.addObject("csp_id", csp_id);
	    mv.addObject("commentList", commentList);
	    mv.addObject("csp_title", csp_title);
	    mv.setViewName("company/csview");
	    return mv;
	}
	// Company/CswriteForm (문의글 작성)
	@RequestMapping("/CswriteForm")
	public ModelAndView cswriteForm(CompanyVo companyVo,String user_id, String compname, Integer csp_id) {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("companyVo", companyVo);
		mv.addObject("user_id", user_id);
		mv.addObject("csp_id", csp_id);
		mv.setViewName("company/cswrite");
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
		mv.setViewName("redirect:/Company/Cslist");
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
		mv.setViewName("company/csupdate");
		return mv;
		}
		
	// Company/Csupdate (문의글 수정)
	@RequestMapping("/Csupdate")
	public ModelAndView csupdate(CompanyVo companyVo, String user_id, Integer csp_id) {
		companyMapper.updatecs(companyVo);
			
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("csp_id", csp_id);
		mv.setViewName("redirect:/Company/Cslist");
		return mv;
		}
		
	// Company/csdelet (문의글 삭제)
	@RequestMapping("/Csdelete")
	public ModelAndView csdelete(CompanyVo companyVo, String user_id, Integer csp_id) {
		companyMapper.deletecs(companyVo);
		System.out.println(user_id);
		System.out.println(companyVo);
		
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.addObject("csp_id", csp_id);
		mv.setViewName("redirect:/Company/Cslist");
		return mv;
		}
	//------------------------비회원 공고 목록 -------------------------------------//
	@RequestMapping("/Expostlist")
	public ModelAndView expostlist(
			@RequestParam(defaultValue = "1") int page, 
	        @RequestParam(defaultValue = "5") int size
	        ) {		    
		int start = (page - 1) * size;
	    
		List<CompanyVo> mainList = companyMapper.getnoPostList(start, size);
	    
		int totalPosts = companyMapper.getnoTotalPost(); 
		int totalPages = (int) Math.ceil((double) totalPosts / size); 

		ModelAndView mv = new ModelAndView();
	    mv.addObject("mainList", mainList);
	    mv.addObject("currentPage", page);
	    mv.addObject("totalPages", totalPages);
		mv.setViewName("company/expostlist");
		return mv;
	}
	//------------------------비회원 공고 상세 -------------------------------------//
	@RequestMapping("/Expostview")
	public ModelAndView expostview(CompanyVo companyVo) {
				
	    //조회수 증가
		companyMapper.plushit(companyVo);
				
		//글 조회
		CompanyVo vo = companyMapper.getmain(companyVo);
		//System.out.println("vo"+vo);
		
		//기업정보 조회
		String compname = vo.getCompname();
		CompanyVo comp = companyMapper.getcomp(compname);
		//System.out.println("comp"+comp);
				
		//담당자정보 조회
		String userId = vo.getUser_id();
		CompanyVo user = companyMapper.getuser(userId);
		//System.out.println("user"+user);
				
		String       duty   =  vo.getDuty().replace("\n", "<br>");
		vo.setDuty( duty );
				
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo",vo );
		mv.addObject("comp",comp );
		mv.addObject("user",user );
		mv.setViewName("company/expostview");
		return mv;
	}
}