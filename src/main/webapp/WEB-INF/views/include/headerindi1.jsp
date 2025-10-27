<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
/* (공통) 상단(로고,검색창 , 메뉴 , 로그아웃...) css <시작> */
header {

  display: flex;
  align-items: center; 
  justify-content: space-between;  /* 왼쪽 오른쪽 메뉴를 양쪽으로 정렬 */
  position: relative;
  max-width: 1320px; /* 최대 너비 설정 */
  margin: 0 auto; /* 자동으로 좌우 여백을 설정하여 가운데 정렬*/
  width: 100%;
  /* z-index: 1000;  다른 요소 위에 표시 */
  
  a {
  font-family: 'Arial Black', 'Impact', sans-serif !important;
  font-size: 18px !important; /* 모든 a 태그에 적용 */
  font-weight: bold !important; /* 필요에 따라 굵게 설정 */
}
.navbar-brand img {
  width:215px; 
  height:auto; 
  margin-left: 30px;
  margin-right: -5px;
}

.form-control {
  width: 250px; /* 검색창의 너비를 조정 */
}

.btn {
  color: #1A3D91; /* 텍스트 색상 */
  border-color: #1A3D91; /* 테두리 색상 */
}

 .btn:hover {
  color: white; /* 호버 시 텍스트 색상 */
  background-color: #1A3D91; /* 호버 시 배경색 */
}

}

</style>
  <header>
  
  <nav class="navbar navbar-expand-lg navbar-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/Individual/Main?user_id=${param.user_id}"><img src="/img/로고.png"  alt=회사로고/></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            채용공고
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/Individual/Postlistfilter?user_id=${param.user_id}">채용공고 목록(조건별)</a></li>
			<li><a class="dropdown-item" href="/Individual/Postlistsort?user_id=${param.user_id}">채용공고 목록(정렬순)</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            이력서 등록
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/Individual/Resumereg?user_id=${param.user_id}">이력서 등록</a></li>
            <li><a class="dropdown-item" href="/Individual/ResumeList?user_id=${param.user_id}">등록 이력서 관리</a></li>
            <li><a class="dropdown-item" href="/Individual/AppList?user_id=${param.user_id}">지원서 관리</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            채용공고 추천
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/Individual/Recommend?user_id=${param.user_id}">추천 공고 목록</a></li>
            <li><a class="dropdown-item" href="/Individual/Scrap?user_id=${param.user_id}">스크랩한 공고</a></li>
          </ul>
        </li>
        
        <li class="nav-item" style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;">
          <a class="nav-link" href="/Individual/Bookmarking?user_id=${param.user_id}" style="color: #1A3D91 !important;">PICK ME</a>
        </li>

        <li class="nav-item" style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;">
          <a class="nav-link" href="/picktalk/posts?user_id=${sessionScope.login.user_id}" style="color: #1A3D91 !important;">PICK TALK</a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="/Individual/Cslist?user_id=${param.user_id}">고객센터</a>
        </li> 
      </ul>
    </div>
  </div>
</nav>
     <div>
        <input class="form-control me-2" style="color: #1A3D91;" type="search" name="searchtext" id="searchtext" placeholder="Search" aria-label="Search">
        <button class="btn" type="submit" name="imgclick" id="imgclick">검색</button>
      </div>
      
      
      <script>

$(function(){
    $('#imgclick').on('click', function(){
        const searchtext = $('#searchtext').val();
        
        $.ajax({
            url: '/Individual/SearchCheck',
            type: 'GET',
            data: { searchtext: searchtext }
        })
        .done(function(data){
            $('.job-card').remove(); // 기존의 job-card 요소 제거
            $('.mainlist').html(""); 
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
  </header>