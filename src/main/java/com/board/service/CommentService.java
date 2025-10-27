package com.board.service;

import org.springframework.stereotype.Service;

import com.board.mapper.CommentMapper;
import com.board.vo.CommentVo;

import java.util.List;

@Service
public class CommentService {

    private final CommentMapper commentMapper;

    public CommentService(CommentMapper commentMapper) {
        this.commentMapper = commentMapper;
    }

	public List<CommentVo> commentList(Integer csp_id) {
		return commentMapper.commentList(csp_id);
	}

    public CommentVo addComment(CommentVo comment) {
        commentMapper.insertComment(comment);
        return comment;
    }


}
