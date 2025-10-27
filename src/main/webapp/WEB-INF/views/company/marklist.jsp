<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headercomp.jsp" %>
 
    
  <div id="bookmarkSection" >
    <h2 style="text-align:center;">북마크 목록</h2>
      <table>
        <tr>
          <th>이름</th>
          <th>이력서 제목</th>
          <th>전화번호</th>
          <th>생년월일</th>
          <th>자격증</th>
          <th>북마크</th>
          <th>PICK ME</th>
        </tr>
        <c:forEach var="jjim" items="${JJIMLIST}"  varStatus="status">
        <tr>
          <td>${jjim.username}</td>
          <td>
            <a href="/Company/Resumejustview?title=${jjim.title}&user_id=${jjim.user_id}&compname=${jjim.compname}"> 
            ${jjim.title}
            </a>
          </td>
          <td>${jjim.phone_number}</td>
          <td>${jjim.birth}</td>
          <td>${jjim.licenses}</td>
          <td>
            <form action="/Company/BookmarkingJJ" method="post">
              <input type="hidden" name="user_id" value="${jjim.user_id}"> 
              <input type="hidden" name="username" value="${jjim.username}">
              <input type="hidden" name="title" value="${jjim.title}">
              <input type="hidden" name="compname" value="${jjim.compname}">
              <input type="hidden" name="phone_number" value="${jjim.phone_number}">
              <input type="hidden" name="birth" value="${jjim.birth}">
              <button type="submit" class="Scrapbtn" style="background-color: transparent; border-color: transparent;" onclick="jjimButton(this)">
    		    <svg class="w-10 h-10 text-gray-800 text-dark scrapSvg end-0" xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="${scrapStatus[status.index]}" stroke="black" stroke-width="2" viewBox="0 0 24 24">
    			<path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
    			</svg>
    		  </button>
            </form>  
          </td>
          <td>
            <form action="/Company/Bookmarking" method="post">
              <input type="hidden" name="user_id" value="${jjim.user_id}"> 
              <input type="hidden" name="username" value="${jjim.username}">
              <input type="hidden" name="title" value="${jjim.title}">
              <input type="hidden" name="compname" value="${jjim.compname}">
              <input type="hidden" name="phone_number" value="${jjim.phone_number}">
              <input type="hidden" name="birth" value="${jjim.birth}">
              <input type="image" src="/img/pickme.png" alt="PICK ME" onclick="disableButton(this)">
            </form>  
          </td>
        </tr>
        </c:forEach>
      </table>
    </div> 
  </main>
</div>

<script>
        let showingRecommendations = true;

        function toggleSections() {
            const recommendationSection = document.getElementById('recommendationSection');
            const bookmarkSection = document.getElementById('bookmarkSection');

            if (showingRecommendations) {
                recommendationSection.style.display = 'none';
                bookmarkSection.style.display = 'block';
            } else {
                recommendationSection.style.display = 'block';
                bookmarkSection.style.display = 'none';
            }

            showingRecommendations = !showingRecommendations;
        }
</script>

<script>
function disableButton(button) {
    button.disabled = true; // 버튼 비활성화
    button.form.submit(); // 폼 제출
}

function jjimButton(button) {
    button.disabled = true; // 버튼 비활성화
    button.form.submit(); // 폼 제출
}

</script>

<c:if test="${not empty alertMessage}">
    <script type="text/javascript">
        alert("${alertMessage}");
    </script>
</c:if>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>