<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
 
<div class= "div4">
 <main>
    <h2 style="text-align:center; ">등록된 이력서 내역</h2>
    <table>
     <tr>
      <th>이력서제목</th>
      <th>작성일</th>
     </tr>
     
     <c:forEach var="ree" items="${reList}">
      <tr>
       <td>
       <a href="/Individual/Resumeview?title=${ree.title}&user_id=${param.user_id }" >
           ${ ree.title }</a>
       </td>
       <td>${ ree.u_date}</td>
      </tr>
     </c:forEach>
    </table>
 </main>
</div>  
 
<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>