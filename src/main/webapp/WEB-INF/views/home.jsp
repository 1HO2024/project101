<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>
<style>
.div1 {
  margin-top:-35px;
  display: flex; 
  align-items: center; 
  justify-content: center; 
  border-bottom : 1px solid #E8E8E8;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  width:100%;
  padding: 20px;
}

.logo img {
  width:215px; 
  height:auto; 
  margin-left: 30px;
  margin-right: -5px;
}

.search {
  position: relative;
  width: 450px; 
  margin-top: 50px;
}

.search input {
  width: 100%;
  border: 2px solid #1F2C63;
  border-radius: 8px;
  padding: 10px 12px ;
  font-size: 14px;
}

.search img {
  position : absolute;
  width: 18px;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  margin: 0;
}

.headernav {
  width:1320px;
  margin-top: 60px;
  margin-left: -600px; 
  margin-bottom: -80px;
  display: flex; 
  justify-content: flex-start; 
  font-weight: bold;
}

.headernav ul {
  list-style: none; 
  display: flex; 
  margin-top:30px; 
}

.headernav a {
  text-decoration: none; 
  color:black;
}

.leftmenu {
  gap: 20px; 
  padding: 0; 
  margin-left:30px;
  margin-right:400px;
  white-space:nowrap;
}

.rightmenu {
  padding-top:10px;
  margin-left:200px;
  margin-right:auto;
  gap:10px;
  font-size: 13px;
  white-space:nowrap;
}

.rightmenu ul div,
.rightmenu ul li {
    margin-right: 7px; /* 원하는 만큼의 여백 추가 */
}
</style>
<body>

<div class = "div1">
     <h1 class ="logo">
        <a href="/"><img src="/img/로고.png"  alt=회사로고/></a>
     </h1>
     <div class="search">
      <input type="search"  readonly/>
        <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" >
        <span class="stats">
        <c:import url="/stats" />
       </span>
   </div>

   
      <header>
      <nav class ="headernav">
       <ul class="leftmenu"> 
		    <li><a href="/Company/Expostlist">채용공고</a></li>
		    <li style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;"><a href="/Company/ListManagement?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)" style="color: #1A3D91;">PICK TALK</a></li>
		    <li style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;"><a href="/Company/Bookmark?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)" style="color: #1A3D91;">PICK ME</a></li>               
		    <li><a href="/Company/Cslist?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)">고객센터</a></li> 
		</ul>
 
              
            <div class="rightmenu" >   
            <ul>   
               <li><a href="/LoginPick">로그인</a></li>
               <li><a href="/SignupPick">회원가입</a></li>
            </ul>     
            </div>
       </nav>       
    </header>
 </div>

 <div class= "div3">
  <!--메인화면 테스트용 -->
   
   <nav class="legnav"> 
    <c:set var="postList" value="${requestScope.postList}" />
    <c:set var="user_id" value="${param.user_id}" />
    
    <c:choose>
        <c:when test="${not empty postList}">
            <c:forEach var="main" items="${postList}">
                <div class="job-card" onclick="location.href='/Company/Expostview?aplnum=${main.aplnum}'">
                    <img src="${not empty main.logoPath ? main.logoPath : '/img/ex.PNG'}" alt="회사 로고">
                    <div class="company-name">${main.compname}</div>
                    <div class="description">${main.duty}</div>
                    <div class="hit-count">조회수: ${main.hit}</div> 
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="no-posts">등록된 채용공고가 없습니다.</div> 
        </c:otherwise>
    </c:choose>
   </nav>
</div>
    <!-- 수정됨 -->
<div class="pagination">
   <c:if test="${totalPages > 0}">
    <c:if test="${currentPage > 1}">
        <a href="?page=${currentPage - 1}">이전</a>
    </c:if>

    <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
            <c:when test="${i == currentPage}">
                <a href="?page=${i}" class="active">${i}</a> 
            </c:when>
            <c:otherwise>
                <a href="?page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="?page=${currentPage + 1}">다음</a>
    </c:if>  
</c:if>
</div>
   
<script>
     function checkLogin(event, url) {
         let Login = ${not empty sessionScope.login.user_id}; 
         event.preventDefault();            
         if (!Login) {              
             var confirmLogin = confirm("로그인이 필요합니다. 로그인 하시겠습니까?");
             if (confirmLogin) {                
                 window.location.href = "/LoginPick";
             } else {                
                 return false; 
             }
         } else {                
             window.location.href = url; 
         }
     }
</script>	

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>