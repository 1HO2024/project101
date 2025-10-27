<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

 <div class="div4">
	 <main>
	   <h2 style=text-align:center;>PICK ME</h2>
	     <table>
	       <tr>
	        <th>이름</th>
	        <th>생년월일</th>
	        <th>이력서 제목</th>
	        <th>전화번호</th>
	         <th>PICK ME</th>
	       </tr>
	       
	       <c:forEach var="book" items="${bookmarkList}">
	         <form action="/Company/Bookmarking" method="post">
	       <tr>
	        <td>${book.username}</td>
	        <td>${book.birth}</td>
	        <td>
	          <a href="/Company/Resumejustview?title=${book.title}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}"> 
	                ${book.title}
	            </a>
	         </td>
	        <td>${book.phone_number}</td>
	        <td>
	            <input type="hidden" name="user_id" value="${sessionScope.login.user_id}">
            	<input type="hidden" name="compname" value="${sessionScope.login.compname}"> 
	            <input type="hidden" name="username" value="${book.username}" />
	            <input type="hidden" name="title" value="${book.title}" />
	            <input type="hidden" name="phone_number" value="${book.phone_number}">
	        	<input type="submit" value="취소하기" onclick="disableButton(this)" class="btn btn-outline-danger" />
	        </td>
	       </tr>
	       </form>  
	       </c:forEach>       
	       
	     </table>     
	 
	 </main>
</div>


<%@ include file="/WEB-INF/views/include/cpagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>