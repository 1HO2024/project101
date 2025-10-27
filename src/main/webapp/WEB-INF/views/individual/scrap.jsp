<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>
 
<%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
 
 <div class="div4">
	 <main>
	   
<div id="bookmarkSection" >
    <h2 style=text-align:center;>스크랩 목록</h2>
	     <table>
	       <tr>
	        <th>기업명</th>
	        <th>채용공고</th>
	        <th>등록 마감일</th>
	        <th>스크랩</th>
	       </tr>
	       
	       <c:forEach var="re" items="${scrapIds}"  varStatus="status">
	       <tr>
	        <td>${re.compname}</td>
	        <td><a href="/Individual/Postview?aplnum=${re.alpnum}&user_id=${param.user_id}">${re.post_id}</a></td>       
	        <td>${re.deadline}</td>
	        <td>
	         <form action="/Individual/Scrap" method="post">
	       	        <input type="hidden" name="currentUrl" value="/Individual/Scrap?user_id=${param.user_id}"/>
                    <input type="hidden" name="user_id"  value="${param.user_id}"> 
                    <input type="hidden" name="compname" value="${re.compname}">
                    <input type="hidden" name="post_id"  value="${re.post_id}">
                    <input type="hidden" name="deadline" value="${re.deadline}">
	        <button type="submit"   class="Scrapbtn"  style="background-color: transparent; border-color: transparent; ">
                           <svg  class="w-10 h-10 text-gray-800 text-dark scrapSvg end-0 "
                           xmlns="http://www.w3.org/2000/svg"width="50" height="50" fill="${scrapStatuses[status.index]}" viewBox="0 0 24 24" >
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                             d="M12 2l3.09 6.26L22 9.27l-5 4.87L18.18 22 12 18.27 5.82 22 7 14.14 2 9.27l6.91-1.01L12 2z" />
                           </svg>
               </button>
              </form> 
	        </td>
	       </tr>
	       </c:forEach>
	     </table>
	</div>
  </main>
 </div>
 
 
 <c:if test="${not empty alertMessage}">
    <script>alert('${alertMessage}');</script>
</c:if>
<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>