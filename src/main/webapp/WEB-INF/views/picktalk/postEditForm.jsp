<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 수정</title>
</head>
<body>
<c:choose>
    <c:when test="${isCompanyUser}">
        <%@ include file="/WEB-INF/views/include/headercomp.jsp" %> <%-- 기업 사용자 헤더 --%>
    </c:when>
    <c:when test="${isIndividualUser}">
        <%@ include file="/WEB-INF/views/include/headerindi.jsp" %> <%-- 개인 사용자 헤더 --%>
    </c:when>
    <c:otherwise>
        <%@ include file="/WEB-INF/views/include/headerindi.jsp" %> <%-- 기본값으로 개인 헤더 --%>
    </c:otherwise>
</c:choose>
<div class= "div6">
<main>
<h1>게시글 수정</h1>
<form class="form-container" action="/picktalk/posts/${post.post_id}" method="post">
    <input type="hidden" name="user_id" value="${user_id}">
    
    <label for="title">제목:</label>
    <input type="text" name="title" id="title" value="${post.title}" required>

    <label for="content">내용:</label>
    <textarea name="content" id="content" required>${post.content}</textarea>

    <input type="submit" value="수정">
</form>

<a href="/picktalk/posts?user_id=${user_id}">목록으로 돌아가기</a>
</main>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %> 
</body>
</html>
