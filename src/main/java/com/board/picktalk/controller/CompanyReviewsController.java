package com.board.picktalk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.company.mapper.CompanyMapper;
import com.board.company.vo.CompanyVo;
import com.board.individual.mapper.IndividualMapper;
import com.board.picktalk.mapper.CompanyReviewsMapper;
import com.board.picktalk.vo.CompanyReviewsVo;

@Controller
@RequestMapping("/picktalk")
public class CompanyReviewsController {
	
	@Autowired
	private CompanyMapper companyMapper;
	
	@Autowired
	private IndividualMapper individualMapper;
	
	@Autowired
    private CompanyReviewsMapper companyReviewsMapper;
	
	// 리뷰 목록
    @GetMapping("/reviews")
    public ModelAndView getAllreviews(
    		@RequestParam("user_id") String user_id,
    		@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size
    ) {
    	boolean isCompanyUser = companyMapper.checkCompanyUser(user_id) > 0;
        boolean isIndividualUser = individualMapper.checkIndividualUser(user_id) > 0;
        
        int start = (page - 1) * size;
        int totalreviews = companyReviewsMapper.getTotalreviewsCount();
        int totalPages = (int) Math.ceil((double) totalreviews / size);
    	List<CompanyReviewsVo> reviews = companyReviewsMapper.getAllreviews(start, size);
    	
    	ModelAndView mv = new ModelAndView("picktalk/reviews");
        mv.addObject("reviews", reviews);
        mv.addObject("user_id", user_id);
        mv.addObject("isCompanyUser", isCompanyUser);
        mv.addObject("isIndividualUser", isIndividualUser);
        mv.addObject("currentPage", page); 
        mv.addObject("totalReviews", totalreviews); 
        mv.addObject("size", size); 
        mv.addObject("totalPages", totalPages);
    	return mv;   	
    }
    
    // 리뷰 추가 폼
    @GetMapping("/reviewForm")
    public ModelAndView reviewForm(
    		@RequestParam("user_id") String user_id
    ) {
        boolean isCompanyUser = companyMapper.checkCompanyUser(user_id) > 0;
        boolean isIndividualUser = individualMapper.checkIndividualUser(user_id) > 0;
        
        List<CompanyVo> allcompany = companyMapper.getAllCompany();
        
        ModelAndView mv = new ModelAndView("picktalk/reviewForm");
        mv.addObject("user_id", user_id);
        mv.addObject("isCompanyUser", isCompanyUser); 
        mv.addObject("isIndividualUser", isIndividualUser); 
        mv.addObject("allcompany", allcompany); 
        return mv;
    }

    // 리뷰 추가 처리
    @PostMapping("/review")
    public ModelAndView createReview(
            @ModelAttribute CompanyReviewsVo review, 
            @RequestParam("user_id") String user_id, 
            RedirectAttributes redirectAttributes
    ) {
        review.setUser_id(user_id);

        // 평균 평점 계산
        double averageRating = (review.getDifficulty() + review.getMood()) / 2.0;
        review.setRating(averageRating); // 계산된 평균을 rating에 설정

        companyReviewsMapper.insertreview(review);
        companyMapper.updateAverage(review.getCompname());
        
        ModelAndView mv = new ModelAndView("redirect:/picktalk/reviews?user_id=" + user_id);
        return mv;
    }
    
    // 리뷰 수정 폼
    @GetMapping("/reviewEditForm")
    public ModelAndView reviewEditForm(
            @RequestParam("review_id") int review_id,
            @RequestParam("user_id") String user_id
    ) {
        CompanyReviewsVo review = companyReviewsMapper.getReviewById(review_id);
        
        boolean isCompanyUser = companyMapper.checkCompanyUser(user_id) > 0;
        boolean isIndividualUser = individualMapper.checkIndividualUser(user_id) > 0;
        
        ModelAndView mv = new ModelAndView("picktalk/reviewEditForm");
        mv.addObject("review", review);
        mv.addObject("user_id", user_id);
        mv.addObject("isCompanyUser", isCompanyUser);
        mv.addObject("isIndividualUser", isIndividualUser);
        
        return mv;
    }
    
    // 리뷰 수정 처리
    @PostMapping("/reviewUpdate")
    public ModelAndView updateReview(
            @ModelAttribute CompanyReviewsVo review, 
            RedirectAttributes redirectAttributes,
            @RequestParam("user_id") String user_id
    ) {
        // 평균 평점 재계산
        double averageRating = (review.getDifficulty() + review.getMood()) / 2.0;
        review.setRating(averageRating); // 계산된 평균을 rating에 설정

        companyReviewsMapper.updateReview(review);               
        companyMapper.updateAverage(review.getCompname()); 

        ModelAndView mv = new ModelAndView("redirect:/picktalk/reviews");
        mv.addObject("user_id", user_id);
        return mv;
    }
    
    // 리뷰 삭제
    @PostMapping("/reviewDelete")
    public ModelAndView deleteReview(
            @RequestParam("review_id") int review_id,
            @RequestParam("user_id") String user_id,
            RedirectAttributes redirectAttributes
    ) {
        companyReviewsMapper.deleteReview(review_id);
        redirectAttributes.addFlashAttribute("message", "리뷰가 삭제되었습니다.");
        return new ModelAndView("redirect:/picktalk/reviews?user_id=" + user_id);
    }
    
    // 리뷰 상세보기
    @GetMapping("/reviewDetail")
    public ModelAndView reviewDetail(
            @RequestParam("review_id") int review_id,
            @RequestParam("user_id") String user_id
    ) {
        // 리뷰 정보를 조회
        CompanyReviewsVo review = companyReviewsMapper.getReviewById(review_id);
        
        double averageRating = companyMapper.getCompanyAverage(review.getCompname());
        int totalReviews = companyReviewsMapper.getTotalReviewsCount(review.getCompname());

        ModelAndView mv = new ModelAndView("picktalk/reviewDetail");
        mv.addObject("review", review);
        mv.addObject("user_id", user_id);
        mv.addObject("averageRating", averageRating);
        mv.addObject("totalReviews", totalReviews);   

        return mv;
    }
    
 // 리뷰 목록 검색
    @GetMapping("/search")
    @ResponseBody
    public Map<String, Object> getSearchById(@RequestParam String compname) {
       
       Map<String, Object> response = new HashMap<>();
       
       ModelAndView mv = new ModelAndView();
       System.out.println("compname : "+compname);
       String searchCompname = "%" + compname.toUpperCase() + "%"; 
       
       System.out.println("searchCompname : "+searchCompname);
        List<CompanyReviewsVo> searchlist = companyReviewsMapper.findsearch(searchCompname);
        
        System.out.println("searchlist : "+searchlist);
        response.put("searchlist", searchlist);
        return response; // 검색 결과를 보여줄 JSP 페이지 이름
    }
    

}
