<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

  <!-- 받은 이력서 목록_메인화면 -->
  
<div class= "div4">
 <main>
  <h2>채용공고 별 지원서</h2>
    <table>
     <c:forEach var="post" items="${appList}">
     <tr class="post-item">
       <td>${post.post_id}</td>
       <td><button onclick="toggleResume('${post.post_id}', this)" id="button1" class="btn btn-outline-primary" >상세보기</button></td>
     </tr>

     <tr id="resume-${post.post_id}" style="display:none;">
       <td colspan="2">
         <div class="resume-content">
           <table>
     <tr>
      <th style="width:10%;">지원번호</th>
      <th style="width:22%;">이력서제목</th>
      <th style="width:23%;">지원일</th>
      <th style="width:10%;">합격여부</th>
      <th style="width:15%;">점수합격여부</th>
      <th style="width:10%;">실제점수</th>
      <th style="width:10%;">희망점수</th>
     </tr>
     
     <c:forEach var="app" items="${resumeList}" varStatus="status">
     <c:if test="${post.post_id == app.post_id}">
      <tr style="${resultList[status.index] == '불합격' ? 'background-color: #F0F0F0;' : ''}">
       <td>${ app.app_id   }</td>
       <td>
       <a href="/Company/Resumeview?title=${app.title}&post_id=${app.post_id}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}">
           ${ app.title }</a>
       </td>
       <td>${app.app_date}</td>
       <td>${app.result}</td>
       <td>${resultList[status.index]}</td>
       <td>${totalScoreList[status.index]}</td> <!-- 실제 점수 추가 -->
       <td>${hopescoreList[status.index]}</td> <!-- 희망 점수 추가 -->
      </tr>
      </c:if>
     </c:forEach>
     </table>
     </div>
     </c:forEach>
    </table> 
 </main>
</div>  

<script>
function togglePopup() {
    const popup = document.getElementById("notification-popup");
    if (popup.style.display === "none") {
        popup.style.display = "block"; // 팝업 열기
    } else {
        popup.style.display = "none"; // 팝업 닫기
    }
}

function fetchMessages() {
    // 메시지를 가져오는 로직을 여기에 추가
    togglePopup(); // 메시지를 가져온 후 팝업을 열기
}

function filterMessages() {
    const selectedCategory = document.getElementById('category-select').value;
    const messages = document.querySelectorAll('.message-item');

    messages.forEach(message => {
        const messageCategory = message.getAttribute('data-category');
        if (selectedCategory === 'all' || messageCategory === selectedCategory) {
            message.style.display = 'block'; // 선택한 카테고리에 해당하면 표시
        } else {
            message.style.display = 'none'; // 선택한 카테고리에 해당하지 않으면 숨김
        }
    });
}
</script>

<script>
function toggleResume(post_id, button) {
    var resumeRow = document.getElementById("resume-" + post_id);
    if (resumeRow.style.display === "none") {
    	resumeRow.style.display = "table-row"; // 공고 내용 표시
        button.innerText = "숨기기"; // 버튼 텍스트 변경
        button.className = "btn btn-outline-danger"; // 숨기기 버튼 스타일 적용

    } else {
    	resumeRow.style.display = "none"; // 공고 내용 숨기기
        button.innerText = "상세보기"; // 버튼 텍스트 변경
        button.className = "btn btn-outline-primary"; // 상세보기 버튼 스타일로 변경
    }
}
</script>

<%@ include file="/WEB-INF/views/include/cpagination.jsp" %> 
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>