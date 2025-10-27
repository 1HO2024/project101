<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

  <!--채용공고 목록_메인화면 -->
  <div class="div3">
    <main>
    <h2>채용공고</h2>

      <tr>
        <select name="department" id="department" >
          <option value="">직무별</option>
          <option value="기획,전략">기획,전략</option>
          <option value="마케팅,홍보,조사">마케팅,홍보,조사</option>
          <option value="IT,개발,데이터">IT,개발,데이터</option>
          <option value="회계,세무,채무">회계,세무,채무</option>
          <option value="영업,판매,무역">영업,판매,무역</option>
          <option value="서비스">서비스</option>
          <option value="연구,R&D">연구,R&D</option>
        </select>
        <select name="workspace" id="workspace" >
          <option value="">지역별</option>
          <option value="서울">서울</option>
          <option value="부산">부산</option>
          <option value="대구">대구</option>
          <option value="인천">인천</option>
        </select>
        <select name="career" id="career" >
          <option value="">경력별</option>
          <option value="무관">무관</option>
          <option value="신입">신입</option>
          <option value="경력">경력</option>
        </select>
        <select name="edu" id="edu" >
          <option value="">학력별</option>
          <option value="무관">무관</option>
          <option value="고졸">고졸</option>
          <option value="대졸">대졸</option>
          <option value="학사이상">학사이상</option>
          <option value="석사이상">석사이상</option>
          <option value="박사이상">박사이상</option>
        </select>
        <div id="input1">
        <select name="etc" id="etc" >
          <option value=""> -선택- </option>
          <option value="firsts">최신순</option>
          <option value="counts">조회순</option>
          <option value="laters">마감순</option>
        </select>
        <button type="reset" onclick='window.location.reload()'>초기화</button>
        </div>
      </tr>

      <!-- 채용공고 목록 테이블 -->
      <table>
      	<tr>
	      <th>기업명/분야</th>
	      <th>공고명</th>
	      <th>지역/경력/학력</th>
	      <th>마감기한</th>
	      <th>조회수</th>
	    </tr>
	    <tbody class="post-list">
        <c:forEach var="main" items="${mainList}" varStatus="status">
        <tr class="job-row" id="job-${main.aplnum}">
		  <td>
		    <div style="font-weight: bold; font-size: 20px;">${main.compname}</div>
		    ${main.department}
		  </td>
		  <td class="bold">
		    <a href="/Company/Postview?aplnum=${main.aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}"
		       data-aplnum="${main.aplnum}">
		      ${main.post_id} </a>
          </td>
		  <td><span class="location-icon">${main.workspace}</span><br>
		    <span class="career-icon">${main.career}</span><br>
		    <span class="edu-icon">${main.edu}</span></td>
		  <td>
            <div>~${main.deadline}</div>
            <div id="time-left" data-deadline="${main.deadline}">남은 시간<br><span id="time-details"></span></div>
          </td>
          <td>
            ${ main.hit }
          </td>
          
	    </tr>
        </c:forEach>
        </tbody>
      </table>	 
    </main>
  </div>

 <script>
//채용공고 정렬
$(function() {
    // #ajaxtest 선택 시 sortlist 요청
    $('#etc').on('change', function() {
        let selectvalue = $(this).val();
        
        $.ajax({
            url: '/Company/SelectCheck',
            type: 'GET',
            data: { selectvalue: selectvalue, career: '', department: '', workspace: '', edu: '' }
        })
        .done(function(data) {
            console.log(data);
            alert('성공');
            $('.post-list').html(""); // 기존 내용을 초기화
            
            let html = "";
            data.sortlist.forEach(function(a) {
                html += "<tr class='job-row' id='job-" + a.aplnum + "'>"
                     + "<td>"
                     + "<div style='font-weight: bold; font-size: 20px;'>" + a.compname + "</div>"
                     + a.department
                     + "</td>"
                     + "<td class='bold'>"
                     + "<a href='/Company/Postview?aplnum=" + a.aplnum + "&user_id=" + a.user_id + "&compname=" + a.compname + "'>"
                     + a.post_id + "</a>"
                     + "</td>"
                     + "<td>"
                     + "<span class='location-icon'>" + a.workspace + "</span><br>"
                     + "<span class='career-icon'>" + a.career + "</span><br>"
                     + "<span class='edu-icon'>" + a.edu + "</span>"
                     + "</td>"
                     + "<td>"
                     + "<div>~" + a.deadline + "</div>"
                     + "<div id='time-left' data-deadline='" + a.deadline + "'>남은 시간<br><span id='time-details'></span></div>"
                     + "</td>"
                     + "<td>"
                     + a.hit
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
                     + "<td>"
                     + "<div style='font-weight: bold; font-size: 20px;'>" + a.compname + "</div>"
                     + a.department
                     + "</td>"
                     + "<td class='bold'>"
                     + "<a href='/Company/Postview?aplnum=" + a.aplnum + "&user_id=" + a.user_id + "&compname=" + a.compname + "'>"
                     + a.post_id + "</a>"
                     + "</td>"
                     + "<td>"
                     + "<span class='location-icon'>" + a.workspace + "</span><br>"
                     + "<span class='career-icon'>" + a.career + "</span><br>"
                     + "<span class='edu-icon'>" + a.edu + "</span>"
                     + "</td>"
                     + "<td>"
                     + "<div>~" + a.deadline + "</div>"
                     + "<div id='time-left' data-deadline='" + a.deadline + "'>남은 시간<br><span id='time-details'></span></div>"
                     + "</td>"
                     + "<td>"
                     + a.hit
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
}
</script>

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
<%@ include file="/WEB-INF/views/include/cpagination.jsp" %>   
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>