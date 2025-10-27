package com.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.board.company.mapper.CompanyMapper;
import com.board.company.vo.CompanyVo;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	@Autowired
    private CompanyMapper companyMapper;

    // http://localhost:9090
	@RequestMapping("/")
    public String home(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "8") int size,
                       HttpSession session, 
                       Model model) {
        Object user_id = session.getAttribute("user_id");
        int start = (page - 1) * size; 
		int totalPosts = companyMapper.getnoTotalPost();
		int totalPages = (int) Math.ceil((double) totalPosts / size);

        List<CompanyVo> postList = companyMapper.getnoPostList(start, size);

        model.addAttribute("postList", postList);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("user_id", user_id != null ? user_id.toString() : null);

        if (user_id == null) {
            model.addAttribute("loginMessage", "로그인이 필요합니다.");
        }

        return "home"; 
    }

	// ------------------------------- 총합 -------------------------------//
	@RequestMapping("include/stats")
	public String stats(Model model) {
		int totalUsers     = companyMapper.getTotalUsers();
		int totalCompUsers = companyMapper.getTotalCompUsers();
		int totalPost      = companyMapper.getmainTotalPost();
		
		System.out.println("Total Users: " + totalUsers);
		System.out.println("Total Comp Users: " + totalCompUsers);
		System.out.println("Total Posts: " + totalPost);
		
		model.addAttribute("totalUsers", totalUsers);
		model.addAttribute("totalCompUsers", totalCompUsers);
		model.addAttribute("totalPost", totalPost);
		
		return "stats";
		
	}
	
	@RequestMapping("/LoginPick")
	public  String   loginpick() {
		return "/loginpick";
	}
	
	@RequestMapping("/SignupPick")
	public  String   signuppick() {
		return "/signuppick";
	}
	
}
