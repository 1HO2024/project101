<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<style>
main p {
	font-size: 14px;
	color: #1f2c63;
	margin-bottom: 20px;
	text-align: center;
}

.job-postings-row {
    transition: height 0.3s ease; /* 높이 변화에 애니메이션 추가 */
}

.job-postings-content {
    margin-top: 10px; /* 버튼과 공고 내용 사이의 간격 */
}

.job-link {
    color:blue; /* 기본 링크 색상 */
    text-decoration: none; /* 기본 밑줄 제거 */
    font-weight:bolder;
    transition: color 0.3s ease; /* 색상 변화에 애니메이션 추가 */
}

.job-link:hover {
    color: #511252; /* hover 시 색상 변경 */
}
  
.pick{
 	color: blue;
    text-decoration: none; /* 기본 밑줄 제거 */
    font-weight:bolder;
    transition: color 0.3s ease; /* 색상 변화에 애니메이션 추가 */
 }
  
.pick:hover {
    color: #511252; /* hover 시 색상 변경 */
}
</style>

<body>

<%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
 
<div class= "div4">
  <main>
    <h2> PICK ME </h2>
    <p>${ sessionScope.login.username } 님의 PICK ME  요청 기업들</p>
      <table>
        <c:forEach var="book" items="${bookmarkList}">
        <tr class="bookmark-item">
          <td>${book.compname}</td> <!-- 회사 이름 -->
          <td>
            <button onclick="toggleJobPostings('${book.user_id}', this)" id="button1" class="btn btn-outline-primary" >상세보기</button>
          </td>
        </tr>
        
        <tr id="job-postings-${book.user_id}" style="display:none;">
          <td colspan="2">
            <div class="job-postings-content">
              <table>
                <tr>
                  <th>공고 제목</th>
                  <th>업무</th>
                  <th>근무지</th>
                  <th>급여</th>
                  <th>빠른지원</th>
                </tr>
                <c:forEach var="job" items="${jobPostings}">
                  <c:if test="${job.user_id == book.user_id}">
                  <tr>
                    <td ><a href="/Individual/Postview?aplnum=${job.aplnum}&user_id=${param.user_id}"  class="job-link" >${job.post_id}</a></td>
                    <td>${job.duty}</td> 
                    <td>${job.workspace}</td> 
                    <td>${job.salary}</td> 
                    <td><a href="/Individual/Postapp?aplnum=${job.aplnum}&user_id=${param.user_id}" class="pick" style="color: #1A3D91 !important;">PICK ME</a></td>
                  </tr>
                  </c:if>
                </c:forEach>
              </table>
            </div>
          </td>
        </tr>
        </c:forEach>
      </table>
    </main>
  </div>
  
<!-- 메세지 스크립트 -->
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

<script>
function toggleJobPostings(userId, button) {
    var jobPostingsRow = document.getElementById("job-postings-" + userId);
    if (jobPostingsRow.style.display === "none") {
        jobPostingsRow.style.display = "table-row"; // 공고 내용 표시
        button.innerText = "숨기기"; // 버튼 텍스트 변경
        button.className = "btn btn-outline-danger"; // 숨기기 버튼 스타일 적용
    } else {
        jobPostingsRow.style.display = "none"; // 공고 내용 숨기기
        button.innerText = "상세보기"; // 버튼 텍스트 변경
        button.className = "btn btn-outline-primary"; // 상세보기 버튼 스타일로 변경
    }
}
</script>
<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>