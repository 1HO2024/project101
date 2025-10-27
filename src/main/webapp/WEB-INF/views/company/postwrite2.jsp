<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headercomp.jsp" %>

  <!--채용공고 목록_등록 -->
<div class="div10">
<main>
  <h2 style="text-align:center;">채용공고 등록</h2>
  <form id="form" action="/Company/Postwrite?aplnum=${aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}"  method="POST">
  
<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">공고명 <span class="red" style="font-size: 12px;"> * 필수 기재 사항입니다 </span></td>
    </tr>
    <tr>
      <td><input class="input-field" type="text" name="post_id"  placeholder="공고 제목을 입력하세요"></td>
    </tr>
</table>

<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">공고내용 <span class="red" style="font-size: 12px;"> * 필수 기재 사항을 확인해주세요 </span></td>
    </tr>
    <tr>
      <th>모집분야</th>
      <td>
        <%@ include file="/WEB-INF/views/selection/department.jsp" %>
      </td>
      <th><span id="red">*</span>모집인원</th>
      <td><input class="input-field" type="number" name="recruitnum"   id="recruitnum" min="0" max="1000"  /></td>
    </tr>
   <tr>
      <th><span id="red">*</span>마감일</th>
      <td colspan="3">
          <input type="datetime-local"     name="deadline"   id="deadline" class="deadline" /></td> 
   </tr>
</table>

<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">근무조건 <span class="red" style="font-size: 12px;"> * 필수 기재 사항을 확인해주세요 </span></td>
    </tr>
    <tr>
      <th>근무지역</th>
      <td>
        <%@ include file="/WEB-INF/views/selection/workspace.jsp" %>
      </td>
      <th><span id="red">*</span>급여</th>
      <td><input class="input-field" type="number"     name="salary"   id="salary"  /></td>
    </tr>
    <tr>
      <th><span id="red">*</span>직무내용</th>
      <td colspan="3" style="width:100%;">
      <textarea class="input-field" name="duty" id = "duty" maxlength="1300" class="textarea2"></textarea></td>
    </tr>
</table>
    
<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">지원자격</td>
    </tr>
    <tr>
      <th>경력</th>
      <td>
        <select class="select-field" name="career" id="career" >
          <option value="">-선택-</option>
          <option value="무관">무관</option>
          <option value="신입">신입</option>
          <option value="경력(~2년미만)">경력(~2년미만)</option>
          <option value="경력(2년이상~5년미만)">경력(2년이상~5년미만)</option>
          <option value="경력(5년이상~10년미만)">경력(5년이상~10년미만)</option>
          <option value="경력(~10년이상)">경력(~10년이상)</option>
        </select>
      </td>
      <th>경력별 점수</th>
      <td>
        <select class="select-field" name="careerscore" id=""careerscore"">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
      </td>
    </tr>
    <tr>
      <th>학력</th>
      <td>
        <select class="select-field" name="edu" id="edu" >
          <option value="">-선택-</option>
          <option value="무관">무관</option>
          <option value="고졸">고졸</option>
          <option value="초대졸">초대졸</option>
          <option value="학사이상">학사이상</option>
          <option value="석사이상">석사이상</option>
          <option value="박사이상">박사이상</option>
        </select>
      </td>
      <th>학력별 점수</th>
      <td>
        <select class="select-field" name="eduscore" id="eduscore">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
      </td>
    </tr>
    <tr>
      <th>자격증</th>
      <td>
        <%@ include file="/WEB-INF/views/selection/licenses.jsp" %>
      </td>
      <th>자격증별 점수</th>
      <td>
        <select class="select-field" name="licensesscore" id="licensesscore">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
      </td>
    </tr>
    <tr>
    <td colspan="4"><input class="input-field" type="text"     name="licenses"   id="licenses"  /> </td>
    </tr>
    <tr>
      <th>보유기술</th>
      <td>
        <%@ include file="/WEB-INF/views/selection/skills.jsp" %>
      </td>
      <th>기술별 점수</th>
      <td>
        <select class="select-field" name="skillsscore" id="skillsscore">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
      </td>
    </tr>
    <tr>
    <td colspan="4"><input class="input-field" type="text"     name="skills"   id="skills"  /></td>
    </tr>
</table> 

<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">합격/불합격 기준<span class="red" style="font-size: 12px;"> * 필수 기재 사항을 확인해주세요 </span></td>
    </tr>
    <tr>
      <th><span id="red">*</span>합격기준점수</th>
      <td name="scoreoutput2" id="scoreoutput2">
        <input class="input-field" type="number" name="hopescore" id="hopescore" min="0" max="100" />
      </td>
    </tr>
    <tr>
      <th>설정한 합격점수</th>
      <td name="scoreoutput" id="scoreoutput">
        <input class="input-field" type="number"/>
      </td>
    </tr>
</table>
      
<table>
    <tr>
      <td colspan="4" class="button">
         <input type="submit" value="글 저장" class="btn btn-outline-primary" />   
         <input type="button" value="목록" id="goList" class="btn btn-outline-success" />
      </td> 
    </tr>
</table>
 </form> 
    <script>
	const  goListEl = document.getElementById('goList')
       goListEl.onclick = function() {
       location.href = '/Company/ListManagement?aplnum=${aplnum}&user_id=${sessionScope.login.user_id}&compname=${sessionScope.login.compname}' 
       }    
    const  formEl            = document.querySelector('form');
    const  post_idEl         = document.querySelector('#post_id');
    const  dutyEl            = document.querySelector('#duty');
    const  salaryEl          = document.querySelector('#salary');
    const  recruitnumEl      = document.querySelector('#recruitnum');
 
    formEl.onsubmit   = function () {           
		if(  post_idEl.value.trim() == ''  ) {
			alert('제목을 입력하세요')
            post_idEl.focus()
           	return  false;
		} 
		if(  salaryEl.value.trim() == ''  ) {
            alert('급여를 입력하세요')
            salaryEl.focus()
           	return  false;
		} 
		if(  recruitnumEl.value.trim() == ''  ) {
            alert('모집인원을 입력하세요')
            recruitnumEl.focus()
           	return  false;
		} 
		if(  dutyEl.value.trim() == ''  ) {
            alert('내용을 입력하세요')
            dutyEl.focus()
           	return  false;
		} 
		return  true;
	}
    </script>
     
  <script>
  // 점수 합 계산
  $(function(){
	  $('#"careerscore",#score2,#licensesscore,#score4,#licensesOption').on('change',function(){
		   let "careerscore" = parseInt($('#"careerscore"').val()) || 0;
	       let eduscore = parseInt($('#eduscore').val()) || 0;
	       let licensesscore = parseInt($('#licensesscore').val()) || 0;
	       let skillsscore = parseInt($('#skillsscore').val()) || 0;
	       
		   let score = "careerscore" + eduscore + licensesscore + skillsscore;
		   $('#scoreoutput').html("설정한 합격 점수 : "+score);
	  })
  })
  </script>
  
  <script>
  // 자격증 추가기능
  $(function(){
      let licensesinsert = '';
      $('#licensesOption').on('change', function(){
          let licensesOption = $('#licensesOption').val();
          
          if (licensesOption) {
              // 이미 선택된 자격증이 있는 경우
              if (licensesinsert.includes(licensesOption)) {
                  alert('이미 선택한 자격증입니다: ' + licensesOption);
              } else {
                  licensesinsert += licensesOption + ",";
                  $('#licenses').val(licensesinsert.slice(0, -1));
              }
          }
      });
  });

  // 보유기술 추가기능
  $(function(){
      let skillsinsert = '';
      $('#skillsOption').on('change', function(){
          let skillsOption = $('#skillsOption').val();
          
          if (skillsOption) {
              // 이미 선택된 보유기술이 있는 경우
              if (skillsinsert.includes(skillsOption)) {
                  alert('이미 선택한 보유기술입니다: ' + skillsOption);
              } else {
                  skillsinsert += skillsOption + ",";
                  $('#skills').val(skillsinsert.slice(0, -1));
              }
          }
      });
  });
  </script>
    </main>
  </div>
 
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>