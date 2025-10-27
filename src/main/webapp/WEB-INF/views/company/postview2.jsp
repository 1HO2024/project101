<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

  <!--채용공고 목록_상세페이지 -->
<div class="div7">
	<main>  

	      <input type="hidden" name="aplnum" value="${vo.aplnum}" />
	      <p class="compname">${vo.compname}</p>
	      <p class="post_id">${vo.post_id}</p>
	    
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
              href="/Company/WriteForm?aplnum=${vo.aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" >새로운 공고 쓰기</a>
           <a class="btn btn-outline-warning"
              href="/Company/PostupdateForm?&aplnum=${vo.aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}">수정</a>
           <a class="btn btn-outline-danger" 
              href="/Company/Postdelete?&aplnum=${vo.aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" >삭제</a>
          <a class="btn btn-outline-success" 
             href="/Company/ListManagement?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" >목록</a>
         </div>	    
     
	  </main>
</div>
  
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>