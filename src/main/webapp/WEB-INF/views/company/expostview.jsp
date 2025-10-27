<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<style>
/* (공통) 상단(로고,검색창 , 메뉴 , 로그아웃...) css <시작> */

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

</head>
<body>

<script>
     function checkLogin(event, url) {
         let Login = ${not empty sessionScope.login.user_id}; 
         event.preventDefault();            
         if (!Login) {              
             var confirmLogin = confirm("로그인이 필요합니다. 하시겠습니까?");
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

<header>
 <div class = "div1">
 	 <h1 class ="logo">
  		<a href="/"><img src="/img/로고.png"  alt=회사로고/></a>
 	 </h1>
     <div class="search">
  		<input type="search" placeholder="#픽미 는 당신을 응원합니다!! ">
  		<img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" >
	</div>

  	
 	  <nav class ="headernav">
       <ul class="leftmenu"> 
		    <li><a href="/Company/Expostlist">채용공고</a></li>
		    <li style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;">
		    <a href="/Company/ListManagement?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)" style="color: #1A3D91;">PICK TALK</a></li>
		    <li style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;">
		    <a href="/Company/Bookmark?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)" style="color: #1A3D91;">PICK ME</a></li>               
		    <li><a href="/Company/Cslist?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)">고객센터</a></li> 
		</ul> 
              
            <div class="rightmenu" >   
            <ul>  
  			   <li><a href="/LoginPick">로그인</a></li>
     		   <li><a href="/SignupPick">회원가입</a></li>
    		</ul>  	
    		</div>
    	</nav> 	    	
  </div>
</header>

  <!--채용공고 목록_상세페이지 -->
<div class="div7">
  <main>  

    <input type="hidden" name="aplnum" value="${vo.aplnum}" />
	<p class="compname">${vo.compname}</p>
	<p  class="post_id">${vo.post_id}</p>
	    
	<table id="table1">
	  <h2>채용정보</h2>
	  <tr class="border-top">
	    <td class="subtitle" colspan="2">지원자격</td>
	    <td class="subtitle" colspan="2">근무조건</td>
	  </tr>
	  <tr>
	    <th>경력</th>
	    <td>${vo.career}</td>
	    <th>직무</th>
	    <td>${vo.department}</td>
	  </tr>
	  <tr>
	    <th>학력</th>
	    <td>${vo.edu}</td>
	    <th>급여</th>
	    <td>${vo.salary}</td>
	  </tr>
	  <tr>
	    <th>자격증</th>
	    <td>${vo.licenses}</td>
	    <th>지역</th>
	    <td>${vo.workspace}</td>
	  </tr>
	  <tr class="border-bottom">
	    <th>보유기술</th>
	    <td>${vo.skills}</td>
	  </tr>
	  <tr>
	    <td class="subtitle" colspan="4">공고내용</td>
	  </tr>
	  <tr>
	    <th>모집인원</th>
	    <td>${vo.recruitnum}</td>
	    <th>마감일</th>
	    <td>${vo.deadline}</td>
	  </tr>	   
	  <tr class="border-bottom">
	    <th>담당업무</th>
	    <td>${vo.duty}</td>
	  </tr>  
	</table>
	     
	<table id="table2">
	  <h2>기업정보</h2>
	  <tr class="border-top">
	    <th>회사명</th>
	    <td>${comp.compname}</td>
	    <th>대표이사</th>
	    <td>${comp.ceo}</td>
	  </tr>
	  <!-- 산업, 사원수 넣어야함 -->
	  <tr>
	    <th>산업</th>
	    <td>${comp.j_date}</td>
	    <th>사원수</th>
	    <td>${comp.j_date}</td>
	  </tr>
	  <tr>
	    <th>설립일</th>
	    <td>${comp.create_date}</td>
	    <th>기업형태</th>
	    <td>${comp.business_type}</td>
	  </tr>
	  <tr class="border-bottom">
	    <th>대표전화</th>
	    <td>${comp.phone_number}</td>
	    <th>주소</th>
	    <td>${comp.address}</td>
	  </tr>
	</table>
	     
	<table id="table3">
	  <h2>담당자</h2>
	  <tr class="border-top">
	    <th>담당자명</th>
	    <td>${user.username}</td>
	    <th>회사명</th>
	    <td>${user.compname}</td>
	  </tr>
	  <tr class="border-bottom">
	    <th>이메일</th>
	    <td>${user.email}</td>
	    <th>연락처</th>
	    <td>${user.phone_number}</td>
	  </tr>
	</table>
	     
    <div class="button" >  
	  <a class="btn btn-outline-primary"
	     href="/Individual/Postapp?aplnum=${vo.aplnum}&user_id=${param.user_id}" onclick="checkLogin(event)">이력서 작성</a>
	  <a class="btn btn-outline-success" 
	     href="/Company/Expostlist?aplnum=${vo.aplnum}">목록</a>
    </div>	 
  </main>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>