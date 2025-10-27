<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
 
<div class= "div4">
 <main>
    <h2 style="text-align:center;">제출한 이력서 내역</h2>
 <table class="table2">
     <tr>
     <th style="width:10%;">지원번호</th>
      <th>지원공고명</th>
      <th>이력서제목</th>
      <th style="width:18%;">지원일</th>
      <th style="width:10%;">합격여부</th>
      <th style="width:15%;">지원취소</th>
     </tr>
     
     <c:forEach var="app" items="${appList}">
      <tr class="tr1">
      <td>${ app.app_id}</td>
       <td class="post_id">${ app.post_id }</td>
       <td class="title">
       <a href="/Individual/Resumejustview?title=${app.title}&user_id=${param.user_id }" >
           ${ app.title }</a>
       </td>
       <td>${ app.app_date }</td>
       <td>${ app.result }</td>    
       
       <td>   
         <form action="/Individual/Delapplist" method="POST"> <!-- POST 요청을 위한 form -->
         <input type="hidden" name="app_id" value="${app.app_id}" />
         <input type="hidden" name="user_id" value="${app.user_id}" />
         <input type="button" value="지원 취소" id="goDel" class="btn btn-outline-danger" />
         </form>
	  </td>
      </tr>
     </c:forEach>
    </table>

 </main>
</div>  
 
<script>


const goDelButtons = document.querySelectorAll('#goDel'); 

goDelButtons.forEach(button => {
    button.onclick = function() {
        const form = this.closest('form'); 
        const confirmed = confirm("정말로 해당 지원 취소 하시겠습니까?\n 취소후 발생한 불이익에 대하여 “회사”는 책임지지 않습니다.");
        if (confirmed) {
            form.submit(); 
        }
    };
});
</script>
<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>