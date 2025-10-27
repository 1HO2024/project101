package com.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.board.vo.CommentVo;

import java.util.List;

@Mapper
public interface CommentMapper {

	List<CommentVo> commentList(Integer csp_id);

    void insertComment(CommentVo comment);

}
