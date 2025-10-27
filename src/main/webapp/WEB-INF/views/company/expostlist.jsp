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
. div3 {
td {
   white-space: nowrap; /* 줄 바꿈 방지 */
   overflow: hidden; /* 넘치는 내용 숨기기 */
   text-overflow: ellipsis; /* 넘치는 내용에 ... 표시 */
   }
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
     <div class="search" >
  		<input type="search" placeholder="#픽미 는 당신을 응원합니다!! " onclick="checkLogin(event)">
  		<img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" >
	</div>

  	
 	  <nav class ="headernav">
       <ul class="leftmenu"> 
		    <li><a href="/Company/Expostlist">채용공고</a></li>
		    <li style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;">
		    <a href="/Company/ListManagement?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)" style="color: #1A3D91;">PICK TALK</a></li>
		    <li style="font-family: 'Arial Black', 'Impact', sans-serif; font-weight: 900;">
		    <a href="/Company/Bookmark?user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}" onclick="checkLogin(event)" style="color: #1A3D91;" >PICK ME</a></li>               
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

  <!--채용공고 목록_메인화면 -->
  <div class="div3">
    <main>
    <table>
    <h2>채용공고</h2>
      <tr>       
        <%@ include file="/WEB-INF/views/selection/department.jsp" %>
        <%@ include file="/WEB-INF/views/selection/workspace.jsp" %>
        <select name="career" id="career" class="select-field" >
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
          <button type="reset" onclick='window.location.reload()' class="btn btn " style=" vertical-align: top;">⟳전체해제</button>
      </tr>
      </table>

      <!-- 채용공고 목록 테이블 -->
      <table>
      	<tr>
	      <th style="width:15%;">기업명/분야</th>
	      <th style="width:40%;">공고명</th>
	      <th style="width:15%;">지역/경력/학력</th>
	      <th style="width:15%;">마감기한</th>
	      <th style="width:15%;">입사지원</th>
	    </tr>
	    <tbody class="post-list">
        <c:forEach var="main" items="${mainList}">
        <tr class="job-row" id="job-${main.aplnum}">
		  <td>
		    <div style="font-weight: bold; font-size: 20px;">${main.compname}</div>
		    ${main.department}
		  </td>
		  <td class="bold" style="text-align: left !important;"><a href="/Company/Expostview?aplnum=${main.aplnum}">
		      ${main.post_id} </a>
          </td>
		  <td style="text-align: left !important;"><span class="location-icon">${main.workspace}</span><br>
		    <span class="career-icon">${main.career}</span><br>
		    <span class="edu-icon">${main.edu}</span></td>
		    
		  <td>
            <div>~${main.deadline}</div>
            <div id="time-left" data-deadline="${main.deadline}">남은 시간<br><span id="time-details"></span></div>
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
			} else {
				clearInterval(interval);
				element.innerHTML = '마감되었습니다';
                row.style.backgroundColor = '#f0f0f0'; // 회색으로 배경색 변경
                row.parentNode.appendChild(row);// 마감된 공고를 테이블의 맨 아래로 이동
			}
		}, 1000);
	});
  </script>
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
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>