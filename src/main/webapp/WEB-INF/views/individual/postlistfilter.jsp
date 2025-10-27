<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headerindi.jsp" %>

  <!--채용공고 목록_메인화면 -->
  <div class="div3">
    <main>
    <h2>채용공고</h2>
      <tr>
        <%@ include file="/WEB-INF/views/selection/department.jsp" %>
        <%@ include file="/WEB-INF/views/selection/workspace.jsp" %>
        <select name="career" id="career" class="select-field">
          <option value="">경력별</option>
          <option value="무관">무관</option>
          <option value="신입">신입</option>
          <option value="경력(~2년미만)">경력(~2년미만)</option>
          <option value="경력(2년이상~5년미만)">경력(2년이상~5년미만)</option>
          <option value="경력(5년이상~10년미만)">경력(5년이상~10년미만)</option>
          <option value="경력(~10년이상)">경력(~10년이상)</option>
        </select>
        <select name="edu" id="edu" class="select-field">
          <option value="">학력별</option>
          <option value="무관">무관</option>
          <option value="고졸">고졸</option>
          <option value="초대졸">초대졸</option>
          <option value="학사이상">학사이상</option>
          <option value="석사이상">석사이상</option>
          <option value="박사이상">박사이상</option>
        </select>
        <button type="reset" onclick='window.location.reload()'class="btn btn " style=" vertical-align: top;">⟳전체해제</button>
      </tr>

      <!-- 채용공고 목록 테이블 -->
      <table>
      	<tr>
	      <th style="width:15%;">기업명/분야</th>
	      <th style="width:37%;">공고명</th>
	      <th style="width:15%;">지역/경력/학력</th>
	      <th style="width:13%;">마감기한</th>
	      <th style="width:8%;">조회수</th>
	      <th style="width:12%;">입사지원</th>
	    </tr>
	    <tbody class="post-list">
        <c:forEach var="main" items="${mainList}" varStatus="status">
        <tr class="job-row" id="job-${main.aplnum}">
		  <td>
		    <div style="font-weight: bold; font-size: 20px;">${main.compname}</div>
		    ${main.department}
		  </td>
		  <td class="bold" style="text-align: left !important;"><a href="/Individual/Postview?aplnum=${main.aplnum}&user_id=${param.user_id}">
		      ${main.post_id} </a>
		      <form action="/Individual/Scrap" method="post" style="display: inline-block; margin-left: 5px;">
		      <input type="hidden" name="currentUrl" value="/Individual/Postlistfilter?user_id=${param.user_id}"/>
              <input type="hidden" name="user_id"  value="${param.user_id}"> 
              <input type="hidden" name="compname" value="${main.compname}">
              <input type="hidden" name="post_id"  value="${main.post_id}">
              <input type="hidden" name="deadline" value="${main.deadline}">
              <button type="submit"   class="Scrapbtn"  style="background-color: transparent; border-color: transparent; display: inline;">
                <svg  class="w-10 h-10 text-gray-800 text-dark scrapSvg end-0 "
                      xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="${scrapStatus[status.index]}" viewBox="0 0 24 24" >
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M12 2l3.09 6.26L22 9.27l-5 4.87L18.18 22 12 18.27 5.82 22 7 14.14 2 9.27l6.91-1.01L12 2z" />
                </svg>
              </button>
              </form>
          </td>
		  <td style="text-align: left !important;">
		    <span class="location-icon">${main.workspace}</span><br>
		    <span class="career-icon">${main.career}</span><br>
		    <span class="edu-icon">${main.edu}</span></td>
		    
		  <td>
            <div>~${main.deadline}</div>
            <div id="time-left" data-deadline="${main.deadline}">남은 시간<br><span id="time-details"></span></div>
          </td>
          <td>
            ${ main.hit }
          </td>
          <td>
            <a class="btn btn-outline-success" href="/Individual/Postapp?aplnum=${main.aplnum}&user_id=${param.user_id}">입사지원</a>
          </td>
	    </tr>
        </c:forEach>
        </tbody>
      </table>	 
    </main>
  </div> 
  <script>
 $(function() {
 // #career, #department, #workspace, #edu 선택 시 matchlist 요청
    $('#career, #department, #workspace, #edu').on('change', function() {
        let career = $('#career').val();
        let department = $('#department').val();
        let workspace = $('#workspace').val();
        let edu = $('#edu').val();
        
        $.ajax({
            url: '/Company/SelectCheck',
            type: 'GET',
            data: { selectvalue: '', career: career, department: department, workspace: workspace, edu: edu }
        })
        .done(function(data) {
            console.log(data);
            alert('성공');
            $('.post-list').html(""); // 기존 내용을 초기화
            
            let html = "";
            data.matchlist.forEach(function(a) {
                html += "<tr class='job-row' id='job-" + a.aplnum + "'>"
                     + "<td style='width:15%;'>"
                     + "<div style='font-weight: bold; font-size: 20px;'>" + a.compname + "</div>"
                     + a.department
                     + "</td>"
                     + "<td class='bold' style='text-align: left !important;width:37%;'>"
                     + "<a href='/Company/Postview?aplnum=" + a.aplnum + "&user_id=" + a.user_id + "&compname=" + a.compname + "'>"
                     + a.post_id + "</a>"
                     + "</td>"
                     + "<td style='text-align: left !important;width:15%;'>"
                     + "<span class='location-icon'>" + a.workspace + "</span><br>"
                     + "<span class='career-icon'>" + a.career + "</span><br>"
                     + "<span class='edu-icon'>" + a.edu + "</span>"
                     + "</td>"
                     + "<td style='width:13%;'>"
                     + "<div>~" + a.deadline + "</div>"
                     + "<div id='time-left' data-deadline='" + a.deadline + "'>남은 시간<br><span id='time-details'></span></div>"
                     + "</td>"
                     + "<td style='width:8%;'>"
                     + a.hit
                     + "</td>"
                     + "<td style='width:12%;'>" 
                     + "<a class='btn btn-outline-success' href='/Individual/Postapp?aplnum=" + a.aplnum + "&user_id=" + a.user_id + "'>입사지원"
                     + "</a>"
                     + "</td>"
                     + "</tr>";
            });

            $('.post-list').append(html);
            calculateRemainingTime(); // 남은 시간 계산 함수 호출
        })
        .fail(function(err) {
            console.log(err);
            alert('오류 : ' + err.responseText);
        });
    });
});

function calculateRemainingTime() {
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
element.querySelector('#time-details').innerHTML = days + '일 ' + hours + ':' + minutes + ':' + seconds ;

// 3일 남을 경우 맨 위로 이동 
// 젤 위의 테이블로 옮기는 걸로 바꾸면 됨. 깜박거리는거 해결해야 함
// if (days <= 3) {
// if (row !== tableBody.firstElementChild) { // 이미 맨 위가 아닐 경우에만 이동
// tableBody.insertBefore(row, tableBody.firstElementChild); // 행을 맨 위로 이동
// }
// }

} else {
clearInterval(interval);
element.innerHTML = '마감되었습니다';
            row.style.backgroundColor = '#f0f0f0'; // 회색으로 배경색 변경
            row.parentNode.appendChild(row);// 마감된 공고를 테이블의 맨 아래로 이동
}

}, 10);
  });
}

 </script>
  <script>
	document.querySelectorAll('#time-left').forEach(function(element) {
		const deadline = new Date(element.getAttribute('data-deadline')).getTime();
		const row = element.closest('.job-row');
		const tableBody = row.parentNode;
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
				element.querySelector('#time-details').innerHTML = days + '일 ' + hours + ':' + minutes + ':' + seconds ;
				
				// 3일 남을 경우 맨 위로 이동 
				// 젤 위의 테이블로 옮기는 걸로 바꾸면 됨. 깜박거리는거 해결해야 함
				// if (days <= 3) {
				//	if (row !== tableBody.firstElementChild) { // 이미 맨 위가 아닐 경우에만 이동
				//		tableBody.insertBefore(row, tableBody.firstElementChild); // 행을 맨 위로 이동
				//	}
				// }
				
			} else {
				clearInterval(interval);
				element.innerHTML = '마감되었습니다';
                row.style.backgroundColor = '#f0f0f0'; // 회색으로 배경색 변경
                row.parentNode.appendChild(row);// 마감된 공고를 테이블의 맨 아래로 이동
			}
		}, 10);
	});
  </script>

<c:if test="${not empty alertMessage}">
    <script type="text/javascript">
        alert("${alertMessage}");
    </script>
</c:if>
<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>   
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>