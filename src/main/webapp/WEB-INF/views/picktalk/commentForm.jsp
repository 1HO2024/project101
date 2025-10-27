<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>댓글 추가</title>
</head>
<body>
<h1>댓글 추가</h1>
<form class="comment-form" action="/picktalk/comments" method="post">
    <input type="hidden" name="post_id" value="${param.post_id}"> 
    <input type="hidden" name="user_id" value="${user_id}"> 
    
    <label for="content">내용:</label>
    <textarea name="content" id="content" required></textarea>
    
    <input type="submit" value="추가">
</form>

<a href="/picktalk/posts?user_id=${user_id}">목록으로 돌아가기</a>
</body>
</html>
