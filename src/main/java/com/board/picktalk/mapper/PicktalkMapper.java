package com.board.picktalk.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.board.picktalk.vo.PicktalkCommentVo;
import com.board.picktalk.vo.PicktalkVo;

@Mapper
public interface PicktalkMapper {
    List<PicktalkVo> getAllPosts(@Param("start") int start, @Param("size") int size); // 모든 게시물 조회 페이징
    int getTotalPostsCount(); // 게시물 수 조회
    List<PicktalkCommentVo> getCommentsByPostId(int post_id); // 댓글 조회
    void insertPost(PicktalkVo post); // 게시글 추가
    void insertComment(PicktalkCommentVo comment); // 댓글 추가
    void incrementVCount(int post_id); // 조회수 증가
    PicktalkVo getPostById(int post_id); // 게시글 조회 (ID로)
    void updatePost(PicktalkVo post); // 게시글 수정
    void deletePost(Map<String, Object> params); // 게시글 삭제
    void updateComment(PicktalkCommentVo comment); // 댓글 수정
    void deleteComment(int comment_id); // 댓글 삭제
    void deleteCommentsByPostId(int post_id); // 게시글에 대한 댓글 삭제
    int checkUserExists(String user_id); // 반환 타입 int
    PicktalkCommentVo getCommentById(int comment_id);

}
