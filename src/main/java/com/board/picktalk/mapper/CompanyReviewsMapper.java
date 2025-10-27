package com.board.picktalk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.board.picktalk.vo.CompanyReviewsVo;

@Mapper
public interface CompanyReviewsMapper {
	List<CompanyReviewsVo> getAllreviews(@Param("start") int start, @Param("size") int size);  // 모든 리뷰 목록 조회
    int getTotalreviewsCount(); // 총 리뷰 목록 수
    void insertreview(CompanyReviewsVo review); // 리뷰 추가
    CompanyReviewsVo getReviewById(int review_id); // 리뷰 아이디로 조회
    void updateReview(CompanyReviewsVo review); // 리뷰 수정
    void deleteReview(int review_id); // 리뷰 삭제
    int getTotalReviewsCount(@Param("compname") String compname); // 총 기업 리뷰 수
    List<CompanyReviewsVo> findsearch(String searchCompname); // 리뷰검색
}