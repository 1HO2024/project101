<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
/* (공통) 상단(로고,검색창 , 메뉴 , 로그아웃...) css <시작> */
.rightmenu {
  display: flex;
  font-size: 13px;
  white-space: nowrap;
  justify-content: right;
  max-width: 1100px; /* 최대 너비 설정 */
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
      <div class="rightmenu" >   
        <ul>  
          <div>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${ sessionScope.login.user_id } 님 환영합니다<br>
          </div>  
  	      <li><a href="/Individual/Logout">로그아웃</a></li>
       	  <li><a href="/Individual/Mypage?user_id=${param.user_id}">마이페이지</a></li>
        <li>
       <a href="#" id="message" style="font-size: 20px;" onclick="fetchMessages()">
         알림✉ <span id="notification-count" style="color: red; font-weight: bold; font-size: 13px; margin-left:-3px;"> 
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

       <div id="notification-list" style="width:350px;">
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
                    <a href="#">${message.mcontent}</a> <!-- 기본 URL -->
                </c:otherwise>
            </c:choose>
                  <li>${message.stime}</li>
               </div>
        </c:forEach>
        </div>
     </div>  
      </div>
      
    </nav>   
    </div>

<script>
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