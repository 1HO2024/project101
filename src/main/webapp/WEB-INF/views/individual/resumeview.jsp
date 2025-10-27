<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
 
  <!--이력서_상세페이지 -->

<div class= "div9">
  <main>    
    <p class="title">${vo.title}</p>
    <form action="/Individual/Resumeupdate?title=${vo.title }&user_id=${param.user_id } "method="POST" >
    
    <table id="table1">
    <h2>인적사항</h2>
    <tr class="border-top">
     <td rowspan="6"><img src="${vo.photoPath}" alt="이력서 사진" style="width:150px; height:auto;"></td>
	 <td rowspan="6"></td>
	 <th>성함</th>
	 <td>${vo.username}</td>
    </tr>
    <tr>
     <th>생년월일</th>
     <td>${vo.birth}</td>
    </tr>
    <tr>
     <th>성별</th>
     <td>${vo.gender}</td>
    </tr>
    <tr>
     <th>이메일</th>
     <td>${vo.email}</td>
    </tr>
    <tr>
     <th>연락처</th>
     <td>${vo.phone_number}</td>
    </tr>
    <tr class="border-bottom">
     <th>주소</th>
     <td>${vo.address}</td>
    </tr>
    </table>
    
    <table id="table2">
    <h2>경력 및 학력</h2>
     <tr class="border-top">
      <td class="subtitle" colspan="2">경력</td>
	  <td class="subtitle" colspan="2">학력</td>
	 </tr>
	 <tr>
      <th>경력구분</th>
      <td>${vo.career}</td>
      <th>학력구분</th>
      <td>${vo.edu}</td>
     </tr>
     <tr>
      <th rowspan="3" style="vertical-align: top;">경력내용</th>
      <td rowspan="3" style="vertical-align: top;">${vo.careers}</td>
      <th>학교명</th>
      <td>${vo.eduwher}</td>
     </tr>
     <tr>
      <th>전공</th>
      <td>${vo.major}</td>
     </tr>
     <tr class="border-bottom">
      <th>기간</th>
      <td>${vo.eduwhen}</td>
     </tr>
    </table>
     
    <table id="table3">
    <h2>보유기술 및 자격증</h2>
     <tr class="border-top">
      <td class="subtitle" colspan="2">보유기술</td>
	  <td class="subtitle" colspan="2">자격증</td>
	 </tr>
	 <tr>
      <th rowspan="4" style="vertical-align: top;">보유기술</th>
      <td rowspan="4" style="vertical-align: top;">${vo.skills1}</td>
     </tr>
     <tr>
      <th>자격증1</th>
      <td>${vo.licenses1}  (${vo.publisher1}, ${vo.passdate1})</td>
     </tr>
     <tr>
      <th>자격증2</th>
      <td>${vo.licenses2}  (${vo.publisher2}, ${vo.passdate2})</td>
     </tr>
     <tr class="border-bottom">
      <th>자격증3</th>
      <td>${vo.licenses3}  (${vo.publisher3}, ${vo.passdate3})</td>
     </tr>
    </table>
    
    <table id="table4">
    <h2>포트폴리오</h2>
     <tr class="border-top">
      <td class="subtitle">포트폴리오</td>
     <td colspan="3">${vo.portfolioPath}</td>
    </tr>
    </table>
    
    <table id="table5">
    <h2>자기소개서</h2>
     <tr class="border-top">
	  <td colspan="4">${vo.selfintro}</td>
	 </tr>
    </table>
  </form>   
  
     <div class="button" > 
     <tr>
      <td colspan="4"> 	
       <input type="button" value="수정하기" id="goUpdate" class="btn btn-outline-primary"/>
	   <input type="button" value="삭제하기" id="goDel"    class="btn btn-outline-danger"/>
       <input type="button" value="목록으로" id="goList"   class="btn btn-outline-success"/>
      </td>
     </tr>
    </div>

  </main>
</div>  

	<script>
		const  goListEl    = document.getElementById('goList')
        goListEl.onclick = function() {
        const user_id = '${param.user_id}'; 
        window.location.href = '/Individual/ResumeList?user_id=${param.user_id}'
        };

        const goUpdate = document.getElementById('goUpdate');
        goUpdate.onclick = function() {
            // AJAX 요청을 통해 이력서의 제출 여부를 확인
            $.ajax({
                url: '/Individual/CheckSubmittedResume', // 서버의 URL
                type: 'GET',
                data: {
                    title: '${vo.title}', // 이력서 제목
                    user_id: '${param.user_id}' // 사용자 ID
                },
                success: function(response) {
                    // 서버에서 반환된 응답을 기반으로 제출 여부 설정
                    const submittedResumeExists = response.submitted; // 서버 응답에서 제출 여부 확인

                    if (submittedResumeExists) {
                        alert("수정할 수 없습니다. 현재 제출 상태의 이력서 입니다. \n수정을 원하신다면 취소 후 수정해주십시오 ");
                        return; // 삭제를 진행하지 않음
                    }

                        location.href = '/Individual/Resumeupdate?title=${vo.title}&user_id=${param.user_id}';

                },
                error: function() {
                    alert("이력서 제출 여부를 확인하는 데 실패했습니다.");
                }
            });
        };
   
        const goDel = document.getElementById('goDel');
        goDel.onclick = function() {
            // AJAX 요청을 통해 이력서의 제출 여부를 확인
            $.ajax({
                url: '/Individual/CheckSubmittedResume', // 서버의 URL
                type: 'GET',
                data: {
                    title: '${vo.title}', // 이력서 제목
                    user_id: '${param.user_id}' // 사용자 ID
                },
                success: function(response) {
                    // 서버에서 반환된 응답을 기반으로 제출 여부 설정
                    const submittedResumeExists = response.submitted; // 서버 응답에서 제출 여부 확인

                    if (submittedResumeExists) {
                        alert("삭제할 수 없습니다. 현재 제출 상태의 이력서 입니다. \n삭제를 원하신다면 취소 후 삭제해주십시오 ");
                        return; // 삭제를 진행하지 않음
                    }

                    const confirmed = confirm("정말로 선택한 이력서를 삭제 하시겠습니까?\n기업의 북마크에 담긴 이력서도 사라집니다.");
                    if (confirmed) {
                        location.href = '/Individual/Deleteres?title=${vo.title}&user_id=${param.user_id}';
                    }
                },
                error: function() {
                    alert("이력서 제출 여부를 확인하는 데 실패했습니다.");
                }
            });
        };
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>