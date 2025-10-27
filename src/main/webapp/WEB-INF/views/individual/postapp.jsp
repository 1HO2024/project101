<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
 
  <!--채용공고 목록_상세페이지 -->
  <!--채용공고 목록_상세페이지 -->
<div class="div7">
  <main>  

    <input type="hidden" name="aplnum" value="${vo.aplnum}" />
	<p class="compname">${vo.compname}</p>
	<p  class="post_id">${vo.post_id}</p>
	    
	<table id="table1">
	  <h2>채용정보</h2>
	  <tr class="border-top">
	    <td class="subtitle" colspan="2">지원자격</td>
	    <td class="subtitle" colspan="2">근무조건</td>
	  </tr>
	  <tr>
	    <th>경력</th>
	    <td>${vo.career}</td>
	    <th>직무</th>
	    <td>${vo.department}</td>
	  </tr>
	  <tr>
	    <th>학력</th>
	    <td>${vo.edu}</td>
	    <th>급여</th>
	    <td>${vo.salary}</td>
	  </tr>
	  <tr>
	    <th>자격증</th>
	    <td>${vo.licenses}</td>
	    <th>지역</th>
	    <td>${vo.workspace}</td>
	  </tr>
	  <tr class="border-bottom">
	    <th>보유기술</th>
	    <td>${vo.skills}</td>
	  </tr>
	  <tr>
	    <td class="subtitle" colspan="4">공고내용</td>
	  </tr>
	  <tr>
	    <th>모집인원</th>
	    <td>${vo.recruitnum}</td>
	    <th>마감일</th>
	    <td>${vo.deadline}</td>
	  </tr>	   
	  <tr class="border-bottom">
	    <th>담당업무</th>
	    <td>${vo.duty}</td>
	  </tr>  
	</table>
     
     <!-- 이력서 작성(이력서 불러오기 등)해서 이력서 보내기로 넘어가는 기능 구현하면 어떨까요? -->
    <div class="button" > 
       <a class="btn btn-outline-success" 
          href="/Individual/Postlistfilter?user_id=${param.user_id}" >목록</a>
    </div>	
    
  </main>	  
</div> 
  
  <div class="div4">
  <main>
      <h2>입사 지원서 </h2>
 <form id="applicationForm" action="/Individual/Write2?aplnum=${vo.aplnum}&user_id2=${param.user_id}"method="POST" >
   <input type="hidden" name="aplnum" value="${vo.aplnum}" />
   <input type="hidden" name="post_id" value="${vo.post_id}" />
   <input type="hidden" name="user_id" value="${ param.user_id }" />
    <table id="table">
     <tr>
      <th>지원 공고 번호</th>
       <th>공고 이름</th>
      <th>희망 근무지역 <span class="red"> *</span></th>
       <th>이력서 첨부</th>
     </tr> 
     <tr>
      <td>${  vo.aplnum  }</td>
      <td>${ vo.post_id     }</td>
      <td><input type="text"  name = "location" placeholder="  "></td>
       <td>
          <select name="title">
             <c:forEach items="${titles}" var="title">
                <option  value="${title}">${title}</option>
             </c:forEach>
          </select>
       </td>

     </tr>
     
     <!-- 이력서 작성(이력서 불러오기 등)해서 이력서 보내기로 넘어가는 기능 구현하면 어떨까요? -->
     <tr>
      <td colspan="4">    
        <button type="submit" id="submitBtn" class="btn btn-outline-primary">제출</button>
      </td>
     </tr>
      </table>    
  
    
  
   </form>
  
  </main>
  </div>

<script>
document.getElementById('applicationForm').onsubmit = function(event) {
    event.preventDefault(); // 기본 제출 방지

    const userId = '${param.user_id}';
    const aplnum = '${vo.aplnum}';
    const title = $('select[name="title"]').val();

    // 중복 지원 여부 확인
    $.ajax({
        url: '/Individual/CheckDuplicateApplication',
        type: 'GET',
        data: {
            user_id: userId,
            aplnum: aplnum,
            title: title
        },
        success: function(response) {
            if (response.submitted) {
                alert(" 해당 공고에 지원한 내역이 있습니다. 중복 제출이 불가능합니다.");
            } else {
                // 중복이 없으면 폼 제출
                alert("해당 공고에 지원하셨습니다.");
                document.getElementById('applicationForm').submit();
            }
        },
        error: function() {
            alert("중복 지원 여부를 확인하는 데 실패했습니다.");
        }
    });
};

</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>