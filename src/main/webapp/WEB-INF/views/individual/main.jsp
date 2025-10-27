<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headerindi.jsp" %>

<div class= "div3">
  <!--메인화면 테스트용 -->
   
   <nav class="legnav"> 
    <c:set var="postList" value="${requestScope.postList}" />
    <c:set var="user_id" value="${param.user_id}" />
    
    <c:choose>
        <c:when test="${not empty postList}">
          <table class="mainlist">
            <c:forEach var="main" items="${postList}">
                <div class="job-card" onclick="location.href='/Individual/Postview?aplnum=${main.aplnum}&user_id=${user_id}'">
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
    <!-- 수정됨 -->

<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

$(function(){
    $('#imgclick').on('click', function(){
        const searchtext = $('#searchtext').val();
        
        $.ajax({
            url: '/Company/SearchCheck',
            type: 'GET',
            data: { searchtext: searchtext }
        })
        .done(function(data){
            $('.job-card').remove(); // 기존의 job-card 요소 제거
            $('.mainlist').html(""); // 기존의 job-card 요소 제거
            $('.pagination').hide();

            let html = "";
                html += "<table>"
                     +  "<tr>"
                     + "<th>기업명/분야</th>"
                     + "<th>공고명</th>"
                     + "<th>지역/경력/학력</th>"
                     + "<th>마감기한</th>"
                     + "<th>조회수</th>"
                     +  "</tr>"
                     

            // 각 객체의 속성을 사용하여 HTML 생성
            data.searchlist.forEach(function(a) {
            	html +="<tr class='job-row' id='job-" + a.aplnum + "'>"
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
                html += "</table>";

            // 생성한 HTML을 추가
            $('.mainlist').append(html); // .job-card-container는 실제로 job-card를 담을 요소의 클래스 이름입니다. 
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
</html>