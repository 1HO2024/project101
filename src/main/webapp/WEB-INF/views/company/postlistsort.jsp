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
            <select name="etc" id="etc" class="select-field">
                <option value=""> -선택- </option>
                <option value="firsts" ${selectedSort == 'firsts' ? 'selected' : ''}>최신순</option>
                <option value="counts" ${selectedSort == 'counts' ? 'selected' : ''}>조회순</option>
                <option value="laters" ${selectedSort == 'laters' ? 'selected' : ''}>마감순</option>
            </select>
            <button type="reset" onclick='window.location.reload()' class="btn btn" style="vertical-align: top;">⟳초기화</button>
        </tr>
        <!-- 채용공고 목록 테이블 -->
        <table>
            <tr>
                <th style="width:15%;">기업명/분야</th>
                <th style="width:40%;">공고명</th>
                <th style="width:15%;">지역/경력/학력</th>
                <th style="width:20%;">마감기한</th>
                <th style="width:10%;">조회수</th>
            </tr>
            <tbody class="post-list">
                <c:forEach var="main" items="${mainList}" varStatus="status">
                    <tr class="job-row" id="job-${main.aplnum}">
                        <td>
                            <div style="font-weight: bold; font-size: 20px;">${main.compname}</div>
                            ${main.department}
                        </td>
                        <td class="bold" style="text-align: left !important;">
                            <a href="/Company/Postview?aplnum=${main.aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}"
                               data-aplnum="${main.aplnum}">
                               ${main.post_id}
                            </a>
                        </td>
                        <td style="text-align: left !important;">
                            <span class="location-icon">${main.workspace}</span><br>
                            <span class="career-icon">${main.career}</span><br>
                            <span class="edu-icon">${main.edu}</span>
                        </td>
                        <td>
                            <div>~${main.deadline}</div>
                            <div id="time-left" data-deadline="${main.deadline}">남은 시간<br><span id="time-details"></span></div>
                        </td>
                        <td>
                            ${main.hit}
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
</div>

<script>
// 채용공고 정렬
$(function() {
    // 페이지 로드 시 URL에서 정렬 기준을 읽어와 선택하기
    const urlParams = new URLSearchParams(window.location.search);
    const selectedSort = urlParams.get('sort');
    if (selectedSort) {
        $('#etc').val(selectedSort);
    }

    // 정렬 기준 변경 시 URL 업데이트
    $('#etc').on('change', function() {
        const selectvalue = $(this).val();
        const currentUrl = new URL(window.location.href);
        currentUrl.searchParams.set('sort', selectvalue);
        window.location.href = currentUrl.toString(); // 페이지 이동
    });

    // AJAX 요청 처리
    $('#etc').on('change', function() {
        let selectvalue = $(this).val();
        
        $.ajax({
            url: '/Company/SelectCheck',
            type: 'GET',
            data: { selectvalue: selectvalue, career: '', department: '', workspace: '', edu: '' }
        })
        .done(function(data) {
            console.log(data);
            $('.post-list').html(""); // 기존 내용을 초기화
            
            let html = "";
            data.sortlist.forEach(function(a) {
                html += "<tr class='job-row' id='job-" + a.aplnum + "'>"
                     + "<td style='width:15%;'>"
                     + "<div style='font-weight: bold; font-size: 20px;'>" + a.compname + "</div>"
                     + a.department
                     + "</td>"
                     + "<td class='bold' style='text-align: left !important; width:40%;'>"
                     + "<a href='/Company/Postview?aplnum=" + a.aplnum + "&user_id=" + a.user_id + "&compname=" + a.compname + "&sort=" + selectedSort + "'>"
                     + a.post_id + "</a>"
                     + "</td>"
                     + "<td style='text-align: left !important;width:15%;'>"
                     + "<span class='location-icon'>" + a.workspace + "</span><br>"
                     + "<span class='career-icon'>" + a.career + "</span><br>"
                     + "<span class='edu-icon'>" + a.edu + "</span>"
                     + "</td>"
                     + "<td style='width:20%;'>"
                     + "<div>~" + a.deadline + "</div>"
                     + "<div id='time-left' data-deadline='" + a.deadline + "'>남은 시간<br><span id='time-details'></span></div>"
                     + "</td>"
                     + "<td style='width:10%;'>"
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
                element.querySelector('#time-details').innerHTML = days + '일 ' + hours + ':' + minutes + ':' + seconds;
            } else {
                clearInterval(interval);
                element.innerHTML = '마감되었습니다';
                row.style.backgroundColor = '#f0f0f0'; // 회색으로 배경색 변경
                row.parentNode.appendChild(row); // 마감된 공고를 테이블의 맨 아래로 이동
            }
        }, 10);
    });
}
</script>

<c:if test="${not empty alertMessage}">
    <script type="text/javascript">
        alert("${alertMessage}");
    </script>
</c:if>
<div class="pagination">
   <c:if test="${totalPages > 0}">
    <c:if test="${currentPage > 1}">
        <a href="?page=${currentPage - 1}&user_id=${user_id}&compname=${compname}&sort=${selectedSort}">이전</a>
    </c:if>

    <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
            <c:when test="${i == currentPage}">
                <a href="?page=${i}&user_id=${user_id}&compname=${compname}&sort=${selectedSort}" class="active">${i}</a> 
            </c:when>
            <c:otherwise>
                <a href="?page=${i}&user_id=${user_id}&compname=${compname}&sort=${selectedSort}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="?page=${currentPage + 1}&user_id=${user_id}&compname=${compname}&sort=${selectedSort}">다음</a>
    </c:if>  
</c:if>
</div>
   
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>
