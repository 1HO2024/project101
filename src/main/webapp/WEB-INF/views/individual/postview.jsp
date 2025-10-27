<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>
<style>
        .star {
            color: gold; /* 별 색상 */
            font-size: 20px; /* 별 크기 */
        }
        .star-empty {
            color: lightgray; /* 빈 별 색상 */
        }
        .description {
            font-size: 14px;
            color: black;
            margin-left: 10px; /* 설명과 별 사이의 간격 */
        }
    </style>
<body>

 <%@ include file="/WEB-INF/views/include/headerindi.jsp" %>

  <!--채용공고 목록_상세페이지 -->
<div class="div7">
  <main>  

    <input type="hidden" name="aplnum" value="${vo.aplnum}" />
	<p class="compname">${vo.compname}</p>
<p>
    <strong>기업 평점:</strong> 
    <span>
        <c:forEach var="i" begin="1" end="5">
            <c:if test="${i <= averageRating}">
                <span class="star">★</span> 
            </c:if>
            <c:if test="${i > averageRating}">
                <span class="star star-empty">★</span> 
            </c:if>
        </c:forEach>
    </span> (${totalReviews}개의 리뷰)
</p>
	<span class="post_id">${vo.post_id}
	<form action="/Individual/Scrap" method="post" style="display: inline-block; margin-left: 5px;">
	  <input type="hidden" name="currentUrl" value="/Individual/Postview?aplnum=${vo.aplnum}&user_id=${param.user_id}"/>
  	  <input type="hidden" name="user_id"  value="${param.user_id}"> 
      <input type="hidden" name="compname" value="${vo.compname}">
      <input type="hidden" name="post_id"  value="${vo.post_id}">
      <input type="hidden" name="deadline" value="${vo.deadline}">
      <button type="submit"   class="Scrapbtn"  style="background-color: transparent; border-color: transparent; display: inline;">
        <svg  class="w-10 h-10 text-gray-800 text-dark scrapSvg end-0 "
              xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="${scrapStatus}" viewBox="0 0 24 24" >
        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M12 2l3.09 6.26L22 9.27l-5 4.87L18.18 22 12 18.27 5.82 22 7 14.14 2 9.27l6.91-1.01L12 2z" />
        </svg>
      </button>
    </form> 
    </span>
   
	    
	<table id="table1">
	  <h2 style="margin-top: 30px;">채용정보</h2>
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
	     href="/Individual/Postapp?aplnum=${vo.aplnum}&user_id=${param.user_id}" >이력서 작성</a>
	  <a class="btn btn-outline-success" 
	     href="/Individual/Postlistfilter?aplnum=${vo.aplnum}&user_id=${param.user_id}" >목록</a>
    </div>	 
    
  </main>
</div>

<c:if test="${not empty alertMessage}">
    <script>alert('${alertMessage}');</script>
</c:if>
	  
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>