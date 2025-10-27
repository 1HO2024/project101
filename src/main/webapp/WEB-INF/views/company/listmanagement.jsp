<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headercomp.jsp" %>
 
 <div class="div3">
	 <main>
	    <table>
	    <h2 style=text-align:center;>등록 공고 게시판</h2>
      	<tr>
	      <th style="width:15%;">기업명/분야</th>
	      <th style="width:40%;">공고명</th>
	      <th style="width:15%;">지역/경력/학력</th>
	      <th style="width:20%;">마감기한</th>
	      <th style="width:10%;">조회수</th>
	    </tr>
        <c:forEach var="main" items="${CompanyList}">
        <tr class="job-row" id="job-${main.aplnum}">
		  <td>
		    <div style="font-weight: bold; font-size: 20px;">${main.compname}</div>
		    ${main.department}
		  </td>
		  <td class="bold" style="text-align: left !important;"><a href="/Company/Postview2?aplnum=${main.aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}">
		      ${main.post_id} </a>
          </td>
		  <td style="text-align: left !important;"><span class="location-icon">${main.workspace}</span><br>
		    <span class="career-icon">${main.career}</span><br>
		    <span class="edu-icon">${main.edu}</span></td>
		  <td>
            <div>~${main.deadline}</div>
            <div id="time-left" data-deadline="${main.deadline}">남은 시간<br><span id="time-details">일 0시간 0분 0초</span></div>
          </td>
		  <td>
            ${ main.hit }
          </td>
	    </tr>
        </c:forEach>
      </table>	
	</main>
  </div>

  <script>
	document.querySelectorAll('#time-left').forEach(function(element) {
		const deadline = new Date(element.getAttribute('data-deadline')).getTime();
		const row = element.closest('.job-row');
		const interval = setInterval(function() {
			const now = new Date().getTime();
			const distance = deadline - now;

			// 일, 시간, 분, 초 계산
			const days    = Math.floor(distance / (1000 * 60 * 60 * 24));
			const hours   = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
			const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
			const seconds = Math.floor((distance % (1000 * 60)) / 1000);

			// 남은 시간 표시
			if (distance >= 0) {
				element.querySelector('#time-details').innerHTML = days + '일 ' + hours + ':' + minutes + ':' + seconds;
			} else {
				clearInterval(interval);
				element.innerHTML = '마감되었습니다';
                row.style.backgroundColor = '#f0f0f0'; // 회색으로 배경색 변경
                row.parentNode.appendChild(row);// 마감된 공고를 테이블의 맨 아래로 이동
			}
		}, 1000);
	});
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