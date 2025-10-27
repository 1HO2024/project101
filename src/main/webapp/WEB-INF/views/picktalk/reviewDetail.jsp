<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>리뷰 상세보기</title> 
    <style>
        .star {
            color: gold; /* 별 색상 */
            font-size: 20px; /* 별 크기 */
        }
        .star-empty {
            color: lightgray; /* 빈 별 색상 */
        }
        .description {
            font-size: 14px;
            color: black;
            margin-left: 10px; /* 설명과 별 사이의 간격 */
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/headerindi.jsp" %> 
<div class="div7">
<main>
<h1>리뷰 상세보기</h1>
<p>
    <strong>기업명:</strong> ${review.compname}
</p> 
<p>
    <strong>기업 평점:</strong> 
    <span>
        <c:forEach var="i" begin="1" end="5">
            <c:if test="${i <= averageRating}">
                <span class="star">★</span> 
            </c:if>
            <c:if test="${i > averageRating}">
                <span class="star star-empty">★</span> 
            </c:if>
        </c:forEach>
    </span> (${totalReviews}개 리뷰)
</p>
<p>
    <strong>면접 난이도:</strong> 
    <span style="display: inline-block;">
        <c:forEach var="i" begin="1" end="5">
            <c:if test="${i <= review.difficulty}">
                <span class="star">★</span> 
            </c:if>
            <c:if test="${i > review.difficulty}">
                <span class="star star-empty">★</span> 
            </c:if>
        </c:forEach>
    </span>
        <span class="description" style="display: inline-block; margin-left: 10px;" > 
            <c:choose>
                <c:when test="${review.difficulty == 1}">매우 어려운편 입니다.</c:when>
                <c:when test="${review.difficulty == 2}">어려운편 입니다.</c:when>
                <c:when test="${review.difficulty == 3}">보통인편 입니다.</c:when>
                <c:when test="${review.difficulty == 4}">쉬운편 입니다.</c:when>
                <c:when test="${review.difficulty == 5}">매우 쉬운편 입니다.</c:when>
            </c:choose>
        </span>
</p>
<p>
    <strong>면접 분위기:</strong> 
    <span style="display: inline-block;">
        <c:forEach var="i" begin="1" end="5">
            <c:if test="${i <= review.mood}">
                <span class="star">★</span> 
            </c:if>
            <c:if test="${i > review.mood}">
                <span class="star star-empty">★</span> 
            </c:if>
        </c:forEach>
    </span>
        <span class="description" style="display: inline-block; margin-left: 10px;" > 
            <c:choose>
                <c:when test="${review.mood == 1}">매우 엄중한편 입니다.</c:when>
                <c:when test="${review.mood == 2}">엄중한편 입니다.</c:when>
                <c:when test="${review.mood == 3}">보통인편 입니다.</c:when>
                <c:when test="${review.mood == 4}">편안한편 입니다.</c:when>
                <c:when test="${review.mood == 5}">매우 편안한편 입니다.</c:when>
            </c:choose>
        </span>
</p>
<p><strong>제목:</strong> ${review.title}</p>
<p><strong>내용:</strong> ${review.content}</p>
<p><strong>작성일:</strong> ${review.review_date}</p>
<a href="/picktalk/reviews?user_id=${user_id}">목록으로 돌아가기</a><br>
<c:if test="${user_id == review.user_id}">
    <a href="/picktalk/reviewEditForm?review_id=${review.review_id}&user_id=${user_id}">수정</a>
    <form action="/picktalk/reviewDelete" method="post">
        <input type="hidden" name="review_id" value="${review.review_id}" />
        <input type="hidden" name="user_id" value="${user_id}" />
        <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
    </form>
</c:if>
</main>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
