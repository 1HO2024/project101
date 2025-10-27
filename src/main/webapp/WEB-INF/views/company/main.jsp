<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

 <div class= "div3">
  <!--메인화면 테스트용 -->
   
   <nav class="legnav"> 
    <c:set var="postList" value="${requestScope.postList}" />
    <c:set var="user_id" value="${param.user_id}" />
    
    <c:choose>
        <c:when test="${not empty postList}">
          <table class="mainlist">
            <c:forEach var="main" items="${postList}">
                <div class="job-card" onclick="location.href='/Company/Postview?aplnum=${main.aplnum}&user_id=${user_id}&compname=${sessionScope.login.compname}'">
                    <img src="${not empty main.logoPath ? main.logoPath : '/img/ex.PNG'}" alt="회사 로고">
                    <div class="company-name">${main.compname}</div>
                    <div class="description">${main.duty}</div>
                    <div class="hit-count">조회수: ${main.hit}</div> 
                </div>
            </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-posts">등록된 채용공고가 없습니다.</div> 
        </c:otherwise>
    </c:choose>
   </nav>
</div>
<%@ include file="/WEB-INF/views/include/cpagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</html>