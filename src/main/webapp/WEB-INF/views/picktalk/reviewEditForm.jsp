<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>리뷰 수정</title>
    <style>
        .rating {
            direction: rtl;
            display: inline-block;
        }
        .rating input {
            display: none;
        }
        .rating label {
            font-size: 30px;
            color: gray;
            cursor: pointer;
        }
        .rating input:checked ~ label {
            color: gold;
        }
        .rating label:hover,
        .rating label:hover ~ label {
            color: gold;
        }
        .description {
            font-size: 14px;
            color: black;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
<div class="div6">
<main>
<h1>리뷰 수정</h1>
<form action="/picktalk/reviewUpdate" method="post">
    <input type="hidden" name="user_id" value="${user_id}" />
    <input type="hidden" name="review_id" value="${review.review_id}" />

    <!-- 제목 -->
    <label for="title">제목</label>
    <input type="text" name="title" value="${review.title}" required />

    <!-- 회사 이름 선택 -->
    <label for="compname">회사 이름</label>
    <select name="compname" id="compname" required>
        <option value="${review.compname}" selected>${review.compname}</option>
        <c:forEach var="company" items="${allcompany}">
            <option value="${company.compname}">${company.compname}</option>
        </c:forEach>
    </select>

    <!-- 면접 분위기 -->
    <label for="mood">면접 분위기 :</label>
    <div class="rating">
        <input type="radio" id="mood_star5" name="mood" value="5" <c:if test="${review.mood == 5}">checked</c:if> required />
        <label for="mood_star5">★</label>
        <input type="radio" id="mood_star4" name="mood" value="4" <c:if test="${review.mood == 4}">checked</c:if> />
        <label for="mood_star4">★</label>
        <input type="radio" id="mood_star3" name="mood" value="3" <c:if test="${review.mood == 3}">checked</c:if> />
        <label for="mood_star3">★</label>
        <input type="radio" id="mood_star2" name="mood" value="2" <c:if test="${review.mood == 2}">checked</c:if> />
        <label for="mood_star2">★</label>
        <input type="radio" id="mood_star1" name="mood" value="1" <c:if test="${review.mood == 1}">checked</c:if> />
        <label for="mood_star1">★</label>
    </div>
    <div class="description">
        <span>1: 매우 불편함, 2: 불편함, 3: 보통, 4: 편안함, 5: 매우 편안함</span>
    </div>
    <br>

    <!-- 면접 난이도 -->
    <label for="difficulty">면접 난이도 :</label>
    <div class="rating">
        <input type="radio" id="difficulty_star5" name="difficulty" value="5" <c:if test="${review.difficulty == 5}">checked</c:if> required />
        <label for="difficulty_star5">★</label>
        <input type="radio" id="difficulty_star4" name="difficulty" value="4" <c:if test="${review.difficulty == 4}">checked</c:if> />
        <label for="difficulty_star4">★</label>
        <input type="radio" id="difficulty_star3" name="difficulty" value="3" <c:if test="${review.difficulty == 3}">checked</c:if> />
        <label for="difficulty_star3">★</label>
        <input type="radio" id="difficulty_star2" name="difficulty" value="2" <c:if test="${review.difficulty == 2}">checked</c:if> />
        <label for="difficulty_star2">★</label>
        <input type="radio" id="difficulty_star1" name="difficulty" value="1" <c:if test="${review.difficulty == 1}">checked</c:if> />
        <label for="difficulty_star1">★</label>
    </div>
    <div class="description">
        <span>1: 매우 어려움, 2: 어려움, 3: 보통, 4: 쉬움, 5: 매우 쉬움</span>
    </div>
    <br>

    <!-- 리뷰 내용 입력 -->
    <textarea name="content" placeholder="리뷰 내용" required>${review.content}</textarea>
    <button type="submit">리뷰 수정</button>
</form>
<a href="/picktalk/reviews?user_id=${user_id}">목록으로 돌아가기</a>
</main>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
