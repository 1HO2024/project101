<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<style>
.pick-button.off {
    background-color: #f0f0f0;
    color: #000;
}

.pick-button.on {
    background-color: red;
    color: white;
}
</style>

<body>

 <%@ include file="/WEB-INF/views/include/headercomp.jsp" %>
 
<div class="div4">
  <main>

  <div id="recommendationSection">
   <h2 style=text-align:center;>인재 추천</h2>
     <table>
       <tr>
        <th style="width:10%;">이름</th>
        <th style="width:30%;">이력서 제목</th>
        <th style="width:12%;">학력</th>
        <th style="width:12%;">경력</th>
        <th style="width:26%;">자격증</th>
        <th style="width:10%;">PICK ME</th>
       </tr>

        <c:forEach var="vo" items="${recommendList}" varStatus="status">
      
            <tr>     
                <td>${vo.username}</td>
                <td>
                    <a href="/Company/Resumejustview?title=${vo.title}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}"> 
                        ${vo.title}
                    </a>
                </td>
                <td>${vo.edu}</td>
                <td>${vo.career}</td>
                <td>            
                <c:forEach var="license" items="${fn:split(vo.licenses, ',')}">
                <c:if test="${license == vo.licenses1 || license == vo.licenses2 || license == vo.licenses3}">
                    ${license}
                </c:if>
            </c:forEach>
            </td>

                <td>
               	  <form action="/Company/Bookmarking" method="post">
                  <input type="hidden" name="user_id" value="${sessionScope.login.user_id}"> 
                  <input type="hidden" name="username" value="${vo.username}">
                  <input type="hidden" name="title" value="${vo.title}">
                  <input type="hidden" name="compname" value="${sessionScope.login.compname}">
                  <input type="hidden" name="phone_number" value="${vo.phone_number}">
                  <input type="hidden" name="birth" value="${vo.birth}">
                  <input type="image" src="/img/pickme.png" alt="PICK ME" onclick="disableButton(this)">
               	  </form>  
                </td>
            </tr>         
        </c:forEach>      
    </table>
  </div>    
  </main>
</div>


<script>

function disableButton(button) {
    button.disabled = true; // 버튼 비활성화
    button.form.submit(); // 폼 제출
}

</script>

<c:if test="${not empty alertMessage}">
    <script type="text/javascript">
        alert("${alertMessage}");
    </script>
</c:if>
<%@ include file="/WEB-INF/views/include/cpagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>