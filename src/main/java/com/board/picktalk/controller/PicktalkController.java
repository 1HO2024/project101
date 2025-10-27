package com.board.picktalk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.company.mapper.CompanyMapper;
import com.board.individual.mapper.IndividualMapper;
import com.board.picktalk.mapper.PicktalkMapper;
import com.board.picktalk.vo.PicktalkCommentVo;
import com.board.picktalk.vo.PicktalkVo;

@Controller
@RequestMapping("/picktalk")
public class PicktalkController {
	
	@Autowired
	private CompanyMapper companyMapper;
	
	@Autowired
	private IndividualMapper individualMapper;
	
    @Autowired
    private PicktalkMapper picktalkMapper;

    // 모든 게시글 조회
    @GetMapping("/posts")
    public ModelAndView getAllPosts(
            @RequestParam("user_id") String user_id,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size
    ) {
        int start = (page - 1) * size; 

        // 게시글 목록 조회
        List<PicktalkVo> posts = picktalkMapper.getAllPosts(start, size);
        
        // 총 게시글 수 조회
        int totalPosts = picktalkMapper.getTotalPostsCount();
        int totalPages = (int) Math.ceil((double) totalPosts / size); 

        // 사용자 유형 확인
        boolean isCompanyUser = companyMapper.checkCompanyUser(user_id) > 0;
        boolean isIndividualUser = individualMapper.checkIndividualUser(user_id) > 0;

        ModelAndView mv = new ModelAndView("picktalk/posts");
        mv.addObject("posts", posts);
        mv.addObject("user_id", user_id);
        mv.addObject("isCompanyUser", isCompanyUser);
        mv.addObject("isIndividualUser", isIndividualUser);
        mv.addObject("currentPage", page); 
        mv.addObject("totalPosts", totalPosts); 
        mv.addObject("size", size); 
        mv.addObject("totalPages", totalPages);
        return mv;
    }

    // 게시글 상세보기
    @GetMapping("/posts/{post_id}")
    public ModelAndView getPostDetail(
    		@PathVariable int post_id, 
    		@RequestParam("user_id") String user_id
    		) {
    	// 사용자 유형 확인
        boolean isCompanyUser = companyMapper.checkCompanyUser(user_id) > 0;
        boolean isIndividualUser = individualMapper.checkIndividualUser(user_id) > 0;
    	picktalkMapper.incrementVCount(post_id);
        PicktalkVo post = picktalkMapper.getPostById(post_id);
        List<PicktalkCommentVo> comments = picktalkMapper.getCommentsByPostId(post_id);
        ModelAndView mv = new ModelAndView("picktalk/postDetail");
        mv.addObject("post", post);
        mv.addObject("comments", comments);
        mv.addObject("user_id", user_id);
        mv.addObject("isCompanyUser", isCompanyUser); // 사용자 유형 추가
        mv.addObject("isIndividualUser", isIndividualUser); // 사용자 유형 추가
        return mv;
    }

    // 게시글 추가 폼
    @GetMapping("/postForm")
    public ModelAndView showPostForm(
    		@RequestParam("user_id") String user_id
    		) {
    	// 사용자 유형 확인
        boolean isCompanyUser = companyMapper.checkCompanyUser(user_id) > 0;
        boolean isIndividualUser = individualMapper.checkIndividualUser(user_id) > 0;
        ModelAndView mv = new ModelAndView("picktalk/postForm");
        mv.addObject("user_id", user_id);
        mv.addObject("isCompanyUser", isCompanyUser); // 사용자 유형 추가
        mv.addObject("isIndividualUser", isIndividualUser); // 사용자 유형 추가
        return mv;
    }

    // 게시글 추가
    @PostMapping("/posts")
    public ModelAndView createPost(
    		@ModelAttribute PicktalkVo post, 
    		@RequestParam("user_id") String user_id, 
    		RedirectAttributes redirectAttributes
    		) {
        // 로그인된 사용자 ID 설정
        post.setUser_id(user_id);
        
        picktalkMapper.insertPost(post);
        redirectAttributes.addFlashAttribute("successMessage", "게시글이 추가되었습니다.");
        return new ModelAndView("redirect:/picktalk/posts?user_id=" + user_id);
    }

    // 게시글 수정 폼
    @GetMapping("/posts/{post_id}/edit")
    public ModelAndView editPost(
    		@PathVariable int post_id, 
    		@RequestParam("user_id") String user_id
    		) {
    	// 사용자 유형 확인
        boolean isCompanyUser = companyMapper.checkCompanyUser(user_id) > 0;
        boolean isIndividualUser = individualMapper.checkIndividualUser(user_id) > 0;
        PicktalkVo post = picktalkMapper.getPostById(post_id);
        ModelAndView mv = new ModelAndView("picktalk/postEditForm");
        mv.addObject("post", post);
        mv.addObject("user_id", user_id);
        mv.addObject("isCompanyUser", isCompanyUser); // 사용자 유형 추가
        mv.addObject("isIndividualUser", isIndividualUser); // 사용자 유형 추가
        return mv;
    }

    // 게시글 수정
    @PostMapping("/posts/{post_id}")
    public ModelAndView updatePost(
    		@PathVariable int post_id, 
    		@ModelAttribute PicktalkVo post, 
    		@RequestParam("user_id") String user_id, 
    		RedirectAttributes redirectAttributes
    		) {
        post.setPost_id(post_id);
        post.setUser_id(user_id);

        PicktalkVo existingPost = picktalkMapper.getPostById(post_id);
        if (existingPost != null && existingPost.getUser_id().equals(user_id)) {
            picktalkMapper.updatePost(post);
            redirectAttributes.addFlashAttribute("successMessage", "게시글이 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "수정할 권한이 없습니다.");
        }

        return new ModelAndView("redirect:/picktalk/posts?user_id=" + user_id);
    }

    // 게시글 삭제
    @PostMapping("/posts/{post_id}/delete")
    public ModelAndView deletePost(
    		@PathVariable int post_id, 
    		@RequestParam("user_id") String user_id, 
    		RedirectAttributes redirectAttributes
    		) {
        if (user_id == null || user_id.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "유저 ID가 필요합니다.");
            return new ModelAndView("redirect:/picktalk/posts?user_id=" + user_id);
        }

        // 게시글 확인
        PicktalkVo post = picktalkMapper.getPostById(post_id);
        if (post != null && post.getUser_id().equals(user_id)) {
            // 댓글 삭제
            picktalkMapper.deleteCommentsByPostId(post_id); // 댓글을 먼저 삭제

            // 해시맵 생성
            Map<String, Object> params = new HashMap<>();
            params.put("post_id", post_id);
            params.put("user_id", user_id);

            // 해시맵을 통해 게시글 삭제 메서드 호출
            picktalkMapper.deletePost(params);
            redirectAttributes.addFlashAttribute("successMessage", "게시글과 댓글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "삭제할 권한이 없습니다.");
        }
        return new ModelAndView("redirect:/picktalk/posts?user_id=" + user_id);
    }

    // 댓글 추가
    @PostMapping("/comments")
    public ModelAndView createComment(
    		@ModelAttribute PicktalkCommentVo comment, 
    		@RequestParam("user_id") String user_id, 
    		RedirectAttributes redirectAttributes
    		) {
        // 사용자 ID 검증
        if (user_id == null || user_id.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "유저 ID가 필요합니다.");
            return new ModelAndView("redirect:/picktalk/posts/" + comment.getPost_id());
        }

        // 사용자 ID 유효성 검사
        int userExists = picktalkMapper.checkUserExists(user_id); // 반환 타입 변경 반영
        if (userExists == 0) { // 0이면 유저가 존재하지 않음
            redirectAttributes.addFlashAttribute("errorMessage", "유효하지 않은 사용자 ID입니다.");
            return new ModelAndView("redirect:/picktalk/posts/" + comment.getPost_id());
        }

        // 댓글 추가
        comment.setUser_id(user_id);
        picktalkMapper.insertComment(comment);
        redirectAttributes.addFlashAttribute("successMessage", "댓글이 추가되었습니다.");
        return new ModelAndView("redirect:/picktalk/posts/" + comment.getPost_id() + "?user_id=" + user_id);
    }

 // 댓글 수정
    @PostMapping("/comments/{comment_id}/edit")
    public ModelAndView updateComment(
          @PathVariable int comment_id, 
          @RequestParam("post_id") int post_id,
          @RequestParam("user_id") String user_id, 
          @ModelAttribute PicktalkCommentVo comment,
          RedirectAttributes redirectAttributes
          ) {
        comment.setUser_id(user_id);

        // 댓글 작성자 확인
        PicktalkCommentVo existingComment = picktalkMapper.getCommentById(comment_id);
        if (existingComment != null && existingComment.getUser_id().equals(user_id)) {
            picktalkMapper.updateComment(comment);
            redirectAttributes.addFlashAttribute("successMessage", "댓글이 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "수정할 권한이 없습니다.");
        }

        return new ModelAndView("redirect:/picktalk/posts/" + comment.getPost_id() + "?user_id=" + user_id);
    }

    // 댓글 삭제
    @PostMapping("/comments/{comment_id}/delete")
    public ModelAndView deleteComment(
          @PathVariable int comment_id, 
          @RequestParam("user_id") String user_id, 
          RedirectAttributes redirectAttributes
          ) {
        if (user_id == null || user_id.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "유저 ID가 필요합니다.");
            return new ModelAndView("redirect:/picktalk/posts/");
        }

        PicktalkCommentVo existingComment = picktalkMapper.getCommentById(comment_id);
        if (existingComment != null && existingComment.getUser_id().equals(user_id)) {
            picktalkMapper.deleteComment(comment_id);
            redirectAttributes.addFlashAttribute("successMessage", "댓글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "삭제할 권한이 없습니다.");
        }

        return new ModelAndView("redirect:/picktalk/posts/" + existingComment.getPost_id() + "?user_id=" + user_id);
    }
}
