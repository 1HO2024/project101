<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${post.title}</title> 
</head>
<body>
<%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
<div class="div7">
<main>

<table>
<div>
    <h1>${post.title}</h1>
    <p>작성자: ${post.user_id}</p>
    <p>작성일: ${post.post_date}</p>
    <p>조회수: ${post.vcount}</p>
    <p>${post.content}</p>
    
    <!-- 수정 및 삭제 버튼 추가 -->
    <c:if test="${user_id == post.user_id}">
        <a class="button" href="/picktalk/posts/${post.post_id}/edit?user_id=${user_id}">수정</a>
        <form action="/picktalk/posts/${post.post_id}/delete" method="POST" style="display:inline;">
            <input type="hidden" name="user_id" value="${user_id}">
            <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');">
        </form>
    </c:if>
</div>
</table>

<table>
<h2>댓글</h2>
<div class="comments">
    <c:forEach var="comment" items="${comments}">
        <div class="comment">
            <strong>${comment.user_id}</strong>: ${comment.content}
            <p>작성일: ${comment.comment_date}</p>
            
            <!-- 댓글 삭제 -->
            <c:if test="${user_id == comment.user_id}">
                <a class="button" href="#" onclick="showEditForm(${comment.comment_id}, '${comment.content}')">수정</a>
                <form action="/picktalk/comments/${comment.comment_id}/delete" method="POST" style="display:inline;">
                <input type="hidden" name="user_id" value="${user_id}">
                <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');">
            </form>
            </c:if>
        </div>
        
        <!-- 댓글 수정 폼 -->
        <div id="editForm_${comment.comment_id}" class="edit-form" style="display:none;">
            <h3>댓글 수정</h3>
            <form action="/picktalk/comments/${comment.comment_id}/edit" method="POST">
                <input type="hidden" name="user_id" value="${user_id}">
                <input type="hidden" name="post_id" value="${post.post_id}">
                <input type="hidden" name="comment_id" value="${comment.comment_id}">
                <label for="content">내용:</label>
                <textarea name="content" required>${comment.content}</textarea><br>
                <input type="submit" value="수정 완료">
                <button type="button" onclick="hideEditForm(${comment.comment_id})">취소</button>
            </form>
        </div>
    </c:forEach>
</div>

<!-- 댓글 추가 폼 -->
<form class="comment-form" action="/picktalk/comments" method="POST">
    <input type="hidden" name="user_id" value="${user_id}"> 
    <input type="hidden" name="post_id" value="${post.post_id}"> 
    
    <label for="content">내용:</label>
    <textarea name="content" required></textarea><br>
    <input type="submit" value="댓글 추가">
</form>

</table>
<a href="/picktalk/posts?user_id=${user_id}">목록으로 돌아가기</a>
</main>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script>
function showEditForm(commentId, content) {
    document.getElementById('editForm_' + commentId).style.display = 'block';
}

function hideEditForm(commentId) {
    document.getElementById('editForm_' + commentId).style.display = 'none';
}
</script>
</body>
</html>
