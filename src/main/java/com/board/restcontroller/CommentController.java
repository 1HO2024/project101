package com.board.restcontroller;


import org.springframework.web.bind.annotation.*;

import com.board.service.CommentService;
import com.board.vo.CommentVo;

import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

import java.util.List;

@RestController
@RequestMapping("/api/comments")
public class CommentController {
	
	@Autowired
	private CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    // 댓글 목록 조회
    @GetMapping("/{cspId}")
    public ResponseEntity<List<CommentVo>> getComments(@PathVariable Integer csp_id) {
        List<CommentVo> comments = commentService.commentList(csp_id);
        return new ResponseEntity<>(comments, HttpStatus.OK);
    }

    // 댓글 추가
    @PostMapping
    public ResponseEntity<CommentVo> addComment(@RequestBody CommentVo comment) {
        CommentVo createdComment = commentService.addComment(comment);
        return new ResponseEntity<>(createdComment, HttpStatus.CREATED);
    }
}
