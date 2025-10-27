<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

<div class="div7">
  <main>  
    <table id="table1">
    <h2>문의글</h2>
	<p class="type">${vo.type}</p>
	<p class="csp_title">${vo.csp_title}</p>   
	
     <!-- 구분선 추가 -->
<hr style="border: 1px solid #ccc; margin: 20px 0;">

     <tr>
      <td style="font-weight: bold; font-size: 22px;">문의내용 : </td>
     </tr>
     
     <tr>
      <td colspan="2">${  vo.content    }</td>
     </tr>
     <tr>
      <td style="font-weight: bold; font-size: 22px;">등록된 파일: </td>
     </tr>
     
     <tr>
      <td>
      <c:choose>
            <c:when test="${empty vo.csp_file}">
                <div>등록된 파일이 없습니다.</div>
            </c:when>
            <c:otherwise>
      ${vo.csp_file}
      <!-- 파일 이름 출력 및 다운로드 링크 제공
                <a href="/path/to/files/${vo.csp_file}" target="_blank" download>
                    ${vo.csp_file}
                </a> -->
            </c:otherwise>
        </c:choose>
        </td>
     </tr>
    </table>
     
     <div class="button" >   
       <a class="btn btn-outline-primary" 
         href="/Company/CswriteForm?csp_id=${vo.csp_id}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}">새 글 쓰기</a>
       <c:if test="${login.user_id eq vo.user_id}">
       <a class="btn btn-outline-warning" 
         href="/Company/CsupdateForm?csp_id=${vo.csp_id}&user_id=${sessionScope.login.user_id}&csp_title=${vo.csp_title}&compname=${sessionScope.login.compname}">수정</a>
       <a class="btn btn-outline-danger" 
         href="/Company/Csdelete?csp_id=${vo.csp_id}&user_id=${sessionScope.login.user_id}">삭제</a>
       </c:if>
       <a class="btn btn-outline-success" 
         href="/Company/Cslist?csp_id=${vo.csp_id}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}">목록</a>
     </div>  
     
   <!-- 구분선 추가 -->
<hr style="border: 1px solid #ccc; margin: 20px 0;">  

    <div>
    <h2>답변</h2>
    <div id="comments">
        <!-- 댓글 목록이 여기에 추가됩니다 -->
        <c:choose>
            <c:when test="${empty commentList}">
                <div>답변이 아직 등록되지 않았습니다. 추가 문의가 있으시면 [고객센터]로 연락해 주세요.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="comt" items="${commentList}">
                    <div class="comment">
                        <strong>${comt.user_id}</strong> <span>${comt.c_date}</span>
                        <p>${comt.content}</p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    <textarea id="commentInput" placeholder="답변을 입력하세요"></textarea>
    <input type="button" id="addCommentBtn" value="답변 추가" />
    
    </div>   
  </main>
</div>  

<script>
const cspId = ${vo.csp_id}; // 현재 문의글의 ID
const commentsDiv = document.getElementById('comments');
const commentInput = document.getElementById('commentInput');
const addCommentBtn = document.getElementById('addCommentBtn');

// 댓글 추가하기
addCommentBtn.onclick = async function () {
    const commentContent = commentInput.value.trim();

    if (!commentContent) {
        alert('답변 내용을 입력해주세요.');
        return;
    }

    const newComment = {
        csp_id: cspId,
        user_id: '${sessionScope.login.user_id}', // 현재 로그인한 사용자 ID
        content: commentContent,
    };

    try {
        const response = await fetch('/api/comments', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(newComment),
        });

        if (!response.ok) {
            throw new Error('답변 추가 실패');
        }

        const addedComment = await response.json();
        alert('답변이 추가되었습니다.');

        commentInput.value = ''; // 입력 필드 초기화
        location.reload(); // 댓글 목록 업데이트
    } catch (error) {
        console.error('Error adding comment:', error);
        alert('답변 추가 중 오류가 발생했습니다.');
    }
};

</script>
  
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>