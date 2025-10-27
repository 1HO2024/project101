<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 작성</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/headerindi.jsp" %> 
<div class= "div6">
<main>
<h1>게시글 추가</h1>
<form class="form-container" action="/picktalk/posts" method="post">
    <input type="hidden" name="user_id" value="${user_id}">
    
    <label for="title">제목:</label>
    <input type="text" name="title" id="title" required>

    <label for="content">내용:</label>
    <textarea name="content" id="content" required></textarea>

    <input type="submit" value="추가">
</form>
<a href="/picktalk/posts?user_id=${user_id}">목록으로 돌아가기</a>
</main>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
