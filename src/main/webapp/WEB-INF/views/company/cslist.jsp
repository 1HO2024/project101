<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

  <!-- 고객센터 문의 목록_메인화면 -->
  
<div class= "div4">
 <main>
 
    <table class= "table1">
    <h2 style=text-align:center;>FAQ</h2>
    <tr>
     <td><input type="button" value="문의글 작성" id="goWrite" class="btn btn-primary"/></td>
    </tr>
     <c:forEach var="faq" items="${faqList}">
      <tr>
       <td>[ ${faq.type} ] 
         <a href="#" class="faqtitle">${faq.csp_title}</a> 
       </td>
      </tr>
      <tr>
       <td class="faqcontent" style="display:none;">${ faq.content}</td>
      </tr> 
     </c:forEach>
    </table>
    
         <!-- 공간띄우기 -->
     <div class="space">
       <tr><br><br></tr>
     </div>
     
    <table class= "table2">
     <tr>
      <th>구분</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
     </tr>
     
     <c:forEach var="cs" items="${csList}">
      <tr>
       <td>${ cs.type    }</td>
       <td>
         <c:choose>
           <c:when test="${not empty cs.csp_pw && param.user_id != cs.user_id}">
             <a href="javascript:void(0);" onclick="alert('비밀글입니다. 작성자만 접근할 수 있습니다.');">
              ${cs.csp_title}
             </a>
           </c:when>
    
           <c:when test="${not empty cs.csp_pw && param.user_id == cs.user_id}">
           <c:url var="encodedCspId" value="${cs.csp_id}" />
             <a href="javascript:void(0);" onclick="checkPassword('${encodedCspId}', '${cs.csp_pw}')">
              ${cs.csp_title}
             </a>
           </c:when>
    
           <c:otherwise>
              <a href="/Company/Csview?user_id=${sessionScope.login.user_id}&csp_id=${cs.csp_id}&compname=${sessionScope.login.compname}">
              ${ cs.csp_title }
              </a>
           </c:otherwise>
         </c:choose>
       </td>
       <td>${ cs.user_id }</td>
       <td>${ cs.c_date }</td>
      </tr>
     </c:forEach>
    </table>
 
 <script>    
     document.querySelectorAll('.faqtitle').forEach((title, index) => {
         title.addEventListener('click', function(event) {
             event.preventDefault(); // Prevent default link behavior
             const content = document.querySelectorAll('.faqcontent')[index];
             if (content.style.display === 'none' || content.style.display === '') {
                 content.style.display = 'block';
             } else {
                 content.style.display = 'none';
             }
         });
     });

     const goWrite = document.getElementById('goWrite');
     goWrite.onclick = function() {
         location.href = '/Company/CswriteForm?csp_id=${vo.csp_id}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}';        
     };
     
     function checkPassword(encodedCspId, storedPassword) {
   	  const userPassword = prompt("비밀번호를 입력하세요:");
   	  
   	  // 입력된 비밀번호가 저장된 비밀번호와 일치하면 페이지로 이동
   	  if (userPassword === storedPassword) {
   	    location.href = `/Company/Csview?csp_id=${encodedCspId}&user_id=${param.user_id}&compname=${compname}`;
   	  } else {
   	    alert("비밀번호가 올바르지 않습니다.");
   	  }
   	}
     
</script>
 
 </main>
</div>  
<%@ include file="/WEB-INF/views/include/cpagination.jsp" %> 
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>