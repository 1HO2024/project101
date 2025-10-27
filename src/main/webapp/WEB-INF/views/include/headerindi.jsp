<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
/* (공통) 상단(로고,검색창 , 메뉴 , 로그아웃...) css <시작> */
header {

  display: flex;
  align-items: center; 
  justify-content: center;  /* 왼쪽 오른쪽 메뉴를 양쪽으로 정렬 */
  position: relative;
  max-width: 1600px; /* 최대 너비 설정 */
  margin: 0 auto; /* 자동으로 좌우 여백을 설정하여 가운데 정렬*/
  width: 100%;
  /* z-index: 1000;  다른 요소 위에 표시 */
  
  a {
  font-family: 'Arial Black', 'Impact', sans-serif !important;
  font-size: 18px !important; /* 모든 a 태그에 적용 */
  font-weight: bold !important; /* 필요에 따라 굵게 설정 */
}
.btn {
  color: #1A3D91; /* 텍스트 색상 */
  border-color: #1A3D91; /* 테두리 색상 */
}

 .btn:hover {
  color: white; /* 호버 시 텍스트 색상 */
  background-color: #1A3D91; /* 호버 시 배경색 */
}
.navi {
margin-right: 1000px;
  top: -12px; /* 위로 올리는 값 */
}

.navbar-brand img {
  width:215px; 
  height:auto; 
  margin-left: 30px;
  margin-right: -5px;
}
}
.leftmenu {
  display: flex;
  font-size: 13px;
  white-space: nowrap;
  justify-content: left;
  margin-left: 10px;
  margin-top: -40px;
  width: 100%;
}

.form-control {
  width: 400px; /* 검색창의 너비를 조정 */
}



.rightmenu {
  display: flex;
  font-size: 13px;
  white-space: nowrap;
  justify-content: right;
  padding-right: 40px;
  margin: 0 auto; /* 자동으로 좌우 여백을 설정하여 가운데 정렬*/
  width: 100%;
}

.rightmenu ul {
  display: flex; /* Flexbox를 사용하여 한 줄에 배치 */
  list-style-type: none; /* 기본 리스트 스타일 제거 */
  padding: 0; /* 기본 패딩 제거 */
}

.rightmenu ul li {
  margin-right: 15px; /* 각 항목 간의 여백 */
  font-family: 'Arial Black', 'Impact', sans-serif !important;
  font-size: 15px !important; /* 모든 a 태그에 적용 */
  font-weight: bold !important; /* 필요에 따라 굵게 설정 */
}

.rightmenu a {
  color: black; 
  text-decoration: none; /* 링크의 밑줄 제거 */
  font-family: 'Arial Black', 'Impact', sans-serif !important;
  font-size: 15px !important; /* 모든 a 태그에 적용 */
  font-weight: bold !important; /* 필요에 따라 굵게 설정 */
}

.rightmenu a:hover {
  text-decoration: underline; /* 호버 시 밑줄 추가 */
}

.rightmenu ul div {
  margin-right: 7px; /* 원하는 만큼의 여백 추가 */
}
</style>
  <header>
  
  <nav class="navbar navbar-expand-lg navbar-light">
  <div class="container-fluid"> 
  <table>
   <tr>
    <td rowspan="2">
    <a class="navbar-brand" href="/Individual/Main?user_id=${param.user_id}"><img src="/img/로고.png"  alt=회사로고/></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <td class="navi">
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
    </td>
    <td>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
     </tr>
     
     <tr>
     <td>
     <div class="leftmenu">
        <input class="form-control me-2" style="color: #1A3D91;" type="search" name="searchtext" id="searchtext" placeholder="Search" aria-label="Search">
        <button class="btn" type="submit" name="imgclick" id="imgclick">검색</button>
      </div> 
     </td>
     </tr>
     
     <tr>
     <td colspan="3">
     <div class="rightmenu" > 
          
        <ul>  
          <li>
          ${ sessionScope.login.user_id } 님 환영합니다<br>
          </li>  
  	      <li><a href="/Individual/Logout">로그아웃</a></li>
       	  <li><a href="/Individual/Mypage?user_id=${param.user_id}">마이페이지</a></li>
        <li>
       <a href="#" id="message" style="font-size: 20px;" onclick="fetchMessages()" >
        알림✉ <span id="notification-count" style="color: red; font-weight: bold; font-size: 13px; margin-left:-3px;" > 
            <span>${fn:length(messagelist)}</span>
           </span>
        </a>
   </li>
   </ul>
     <div id="notification-popup" style="display: none; border: 1px solid #ccc; border-radius: 10px; padding: 10px;  position: absolute; max-height: 300px; overflow-y: auto; background-color: #F5F6F8;" >
         <button id="close-popup" style="float: right;  background: none; border: none; font-size: 12px; cursor: pointer;" onclick="togglePopup()">❌</button>
       <h4>받은 메시지</h4>
        <label for="category-select"></label>
     <select id="category-select" onchange="filterMessages()">
        <option value="all">알림</option>
        <option value="공고추천">공고추천</option>
        <option value="지원결과">지원결과</option>
        <option value="PICK ME">PICK ME</option>
        <!-- 추가 카테고리 옵션을 여기에 추가 -->
     </select>

       <div id="notification-list" style="width:500px;">
             <c:forEach var="message" items="${messagelist}">
                 <div class="message-item" data-category="${message.division}"  style="background-color: white; border-radius:5px; paddin">
                    <p> ${message.sender_compname} ${message.division}</p>
                    <c:choose>
                <c:when test="${message.division == '공고추천'}">
                    <a href="/Individual/Recommend?user_id=${message.receiver_userid}">${message.mcontent}</a>
                </c:when>
                <c:when test="${message.division == '지원결과'}">
                    <a href="/Individual/ResumeList?user_id=${message.receiver_userid}">${message.mcontent}</a>
                </c:when>
                <c:when test="${message.division == 'PICK ME'}">
                    <a href="/Individual/Bookmarking?user_id=${message.receiver_userid}">${message.mcontent}</a>
                </c:when>
                <c:otherwise>
                   <a href="#">${message.mcontent}</a>   <!-- 기본 URL -->
                </c:otherwise>
            </c:choose>
                  <li>${message.stime}</li>
               </div>
        </c:forEach>
        </div>
     </div>  
      </div>    
     </td>
     </tr>
     
    </table>
  </div>
</nav>
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
    	
    	function togglePopup() {
    	    const popup = document.getElementById("notification-popup");
    	    if (popup.style.display === "none") {
    	        popup.style.display = "block"; // 팝업 열기
    	    } else {
    	        popup.style.display = "none"; // 팝업 닫기
    	    }
    	}

    	function fetchMessages() {
    	    // 메시지를 가져오는 로직을 여기에 추가
    	    togglePopup(); // 메시지를 가져온 후 팝업을 열기
    	}

    	function filterMessages() {
    	    const selectedCategory = document.getElementById('category-select').value;
    	    const messages = document.querySelectorAll('.message-item');

    	    messages.forEach(message => {
    	        const messageCategory = message.getAttribute('data-category');
    	        if (selectedCategory === 'all' || messageCategory === selectedCategory) {
    	            message.style.display = 'block'; // 선택한 카테고리에 해당하면 표시
    	        } else {
    	            message.style.display = 'none'; // 선택한 카테고리에 해당하지 않으면 숨김
    	        }
    	    });
    	}

    	</script>
  </header>