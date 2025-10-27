<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headerindi.jsp" %>

<div class="div8">
<main>
  <h2>이력서 수정</h2>
 <form id="UpdateForm" action="/Individual/Updating"   method="POST" enctype="multipart/form-data">


<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">이력서제목 <span class="red" style="font-size: 12px;"> * 이력서 제목은 작성 후 수정이 불가합니다 </span></td>
    </tr>
    <tr>
      <td><input class="input-field" type="text" name="title"  value="${vo.title }" ></td>
    </tr>
</table>
  
<table class="table-container" id="info">
    <tr>
    <input type="hidden" name="user_id" value="${param.user_id }">
      <td class="subtitle" colspan="4">인적사항</td>
    </tr>
    <tr>
      <td rowspan="6" style="vertical-align: top;"><input type="text" name="photo" placeholder="증명사진" style="width:250px; height:250px; text-align:center; background-size: cover; background-position: center;" id="photoInput" readonly>
      <input class="test" type="file" name="photo" accept="image/*" style="margin-left: 20px" id="upfile"></td>
      <td rowspan="6"></td>
      <th>성함</th>
      <td><input class="input-field" type="text" name="username" value="${vo.username}" placeholder="이름"></td>
    </tr>    
    <tr>
      <th>생년월일</th>
      <td><input class="input-field" type="text" name="birth" value="${vo.birth}"></td>
    </tr>
    <tr>
      <th>성별</th>
      <td>
        <select class="select-field" name="gender">
          <option value="${vo.gender}">${vo.gender}</option>
          <option value="남자">남자</option>
          <option value="여자">여자</option>
        </select>
      </td>
    </tr>
    <tr>
      <th>이메일</th>
      <td><input class="input-field" type="text" name="email" value="${vo.email}" placeholder="이메일"></td>
    </tr>
    <tr>
      <th>연락처</th>
      <td><input class="input-field" type="text" name="phone_number"  value="${vo.phone_number}" readonly></td>
    </tr>
    <tr>
      <th>주소</th>
      <td><input class="input-field" type="text" name="address"  value="${vo.address}"  readonly></td>
    </tr>
</table>

<table class="table-container" id="career">
    <tr>
      <td class="subtitle" colspan="4">경력사항 <span class="red" style="font-size: 12px;"> * 필수 기재 사항을 확인해주세요 </span></td>
    </tr>
    <tr>
      <td>
      <select class="select-field" name="career">
        <option value="${vo.career}">${vo.career}</option>
        <option value="무관">없음</option>
        <option value="신입">신입</option>
        <option value="경력(~2년미만)">경력(~2년미만)</option>
        <option value="경력(2년이상~5년미만)">경력(2년이상~5년미만)</option>
        <option value="경력(5년이상~10년미만)">경력(5년이상~10년미만)</option>
        <option value="경력(~10년이상)">경력(~10년이상)</option>
      </select>
      </td>
      <td><input class="input-field" type="text" name="careers" value="${vo.careers}"></td>
    </tr>
</table>

<table class="table-container" id="edu">
    <tr>
      <td class="subtitle" colspan="4">학력사항 <span class="red" style="font-size: 12px;"> * 필수 기재 사항을 확인해주세요 </span></td>
    </tr>
    <tr>
      <td>
        <select class="select-field" name="edu"> 
          <option value="${vo.edu }">${vo.edu }</option>
          <option value="무관">없음</option>
		  <option value="고졸">고졸</option>
		  <option value="초대졸">초대졸</option>
		  <option value="학사이상">학사이상</option>
		  <option value="석사이상">석사이상</option>
		  <option value="박사이상">박사이상</option>
        </select>
      </td>
      <td><input class="input-field" type="text" name="eduwher" value="${vo.eduwher}" ></td>
      <td><input class="input-field" type="text" name="major"   value="${vo.major}"></td>
      <td><input class="input-field" type="text" name="eduwhen" value="${vo.eduwhen}"></td>
    </tr>
</table>

<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">보유기술 및 능력</td>
    </tr>
    <tr>
      <td>
        <%@ include file="/WEB-INF/views/selection/updateSkills.jsp" %>
      </td>
      <td><input class="input-field" type="text" name="skills1" id="skills1" value="${vo.skills1}"></td>
    </tr>
</table>

<table class="table-container" id="license">
    <tr>
      <td class="subtitle" colspan="4">자격증</td>
    </tr>
    <tr>
      <td>
        <%@ include file="/WEB-INF/views/selection/updateLicenses1.jsp" %>
      </td>
      <td><input class="input-field" type="text" name="licenses1"  id="licenses1" value="${vo.licenses1}"></td> 
      <td><input class="input-field" type="text" name="publisher1"  value="${vo.publisher1}"></td> 
      <td><input class="input-field" type="date" name="passdate1"   value="${vo.passdate1}" ></td> 
    </tr>
    <tr>
      <td>
        <%@ include file="/WEB-INF/views/selection/updateLicenses2.jsp" %>
      </td>
      <td><input class="input-field" type="text" name="licenses2"  id="licenses2" value="${vo.licenses2}"></td> 
      <td><input class="input-field" type="text" name="publisher2"  value="${vo.publisher2}"></td> 
      <td><input class="input-field" type="date" name="passdate2"   value="${vo.passdate2}" ></td> 
    </tr>
    <tr>
      <td>
        <%@ include file="/WEB-INF/views/selection/updateLicenses3.jsp" %>
      </td>
      <td><input class="input-field" type="text" name="licenses3"  id="licenses3" value="${vo.licenses3}"></td> 
      <td><input class="input-field" type="text" name="publisher3"  value="${vo.publisher3}"></td> 
      <td><input class="input-field" type="date" name="passdate3"   value="${vo.passdate3}" ></td> 
    </tr>
    <tr>
     <td colspan="4">
         <input type="button" id="buttonclick" name="buttonclick" value="자격증 등록" class="btn btn-primary">
         <span class="red" style="font-size: 12px;"> * 자격증 등록을 확인해 주세요. </span>
         <input class="input-field" type="text" name="licenses" id="licenses" value="${vo.licenses}"></td>
    </tr>
</table>    

<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">포트폴리오</td>
    </tr>
    <tr>
      <td><input class="input-field" type="text" name="portfolio" placeholder="주소입력" style="width:650px;"></td>
      <td><input class="test" type="file" name="portfolio" accept="*/*" style="width:300px;" id="portfolioFile"></td>
    </tr>
</table>

<table class="table-container">
    <tr>
      <td class="subtitle" colspan="4">자기소개서</td>
    </tr>
    <tr>
      <td>
      <textarea class="textarea" rows="10" cols="50" name="selfintro" style="width:100%;">${vo.selfintro}</textarea></td>
    </tr>
</table>
      </form>

    <table>
        <tr>
            <td class="endbutton">
                <button class="asidesubmit"  type="submit"  id="checkForm">수정완료</button>   
                <input class="asidesubmit" type="button" value="이전으로" id="goList">
            </td> 
        </tr>
    </table>

      </main>
</div>
 
<script>
const  goList = document.getElementById('goList')
goList.onclick = function() {
   location.href = '/Individual/ResumeList?user_id=${param.user_id}'
} ;


document.getElementById('checkForm').onclick = function(event) {
    event.preventDefault(); // 기본 제출 동작 방지

    const title = document.querySelector('input[name="title"]');
    const birth = document.querySelector('input[name="birth"]');
    const gender = document.querySelector('select[name="gender"]');
    const career = document.querySelector('select[name="career"]');
    const edu = document.querySelector('select[name="edu"]');

    // 필수 입력란 검증
    if (!title.value ) {
        alert("제목을 입력해 주세요.");
        title.focus();
        return false;
    }
    if (birth.value.length !== 8) {
        alert("생년월일을 다시 확인해 주세요.\n (예시) 20241029 ");
        birth.focus();
        return false;
    }
    if (gender.value === "") {
        alert("성별을 선택해 주세요.");
        gender.focus();
        return false;
    }
    if (career.value === "") {
        alert("경력을 선택해 주세요.");
        career.focus();
        return false;
    }
    if (edu.value === "") {
        alert("최종 학력을 선택해 주세요.");
        edu.focus();
        return false;
    }
    // 모든 검증 통과 후 폼 제출
    document.getElementById('UpdateForm').submit();
};
</script>

<script>
	$(document).ready(function() {
	    $("#upfile").on("change", handleImgFileSelect);
	});
	
	function handleImgFileSelect(e) {
	    var files = e.target.files;
	    var reader = new FileReader();
	    reader.onload = function(e) {
	        $("#photoInput").css("background-image", "url(" + e.target.result + ")");
	        $("#photoInput").attr("placeholder", "");  
	    }
	    if (files.length > 0) {
	        reader.readAsDataURL(files[0]);
	    }
	}
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
	                  $('#skills1').val(skillsinsert.slice(0, -1));
	              }
	          }
	      });
	  });
	 
	 //자격증 추가 기능
	 $(function(){
  let licensesinsert1 = '';
  let licensesinsert2 = '';
  let licensesinsert3 = '';

  $('#licensesOption1, #licensesOption2, #licensesOption3').on('change', function(){
      let licensesOption1 = $('#licensesOption1').val();
      let licensesOption2 = $('#licensesOption2').val();
      let licensesOption3 = $('#licensesOption3').val();

      // 선택된 값들을 배열로 만듭니다.
      let selectedOptions = [licensesOption1, licensesOption2, licensesOption3].filter(Boolean);

      // 중복 체크
      let duplicates = selectedOptions.filter((item, index) => selectedOptions.indexOf(item) !== index);
      if (duplicates.length > 0) {
          alert('이미 선택한 자격증입니다: ' + duplicates.join(', '));

          // 각 선택란 초기화
          if (licensesOption1 && duplicates.includes(licensesOption1)) {
              $('#licensesOption1').val('');
          }
          if (licensesOption2 && duplicates.includes(licensesOption2)) {
              $('#licensesOption2').val('');
          }
          if (licensesOption3 && duplicates.includes(licensesOption3)) {
              $('#licensesOption3').val('');
          }
          return; // 중복이 있을 경우 이후 코드 실행을 중단
      }

      // 중복이 없을 경우
      if (licensesOption1) {
          // 다른 선택란에 동일한 값이 있는지 체크
          if (!licensesinsert1.includes(licensesOption1) && !licensesinsert2.includes(licensesOption1) && !licensesinsert3.includes(licensesOption1)) {
              licensesinsert1 += licensesOption1 + ",";
              $('#licenses1').val(licensesinsert1.slice(0, -1));
          } else {
              alert('이미 선택된 자격증입니다: ' + licensesOption1);
              $('#licensesOption1').val(''); // 선택란 초기화
          }
      }
      
      if (licensesOption2) {
          // 다른 선택란에 동일한 값이 있는지 체크
          if (!licensesinsert1.includes(licensesOption2) && !licensesinsert2.includes(licensesOption2) && !licensesinsert3.includes(licensesOption2)) {
              licensesinsert2 += licensesOption2 + ",";
              $('#licenses2').val(licensesinsert2.slice(0, -1));
          } else {
              alert('이미 선택된 자격증입니다: ' + licensesOption2);
              $('#licensesOption2').val(''); // 선택란 초기화
          }
      }
      
      if (licensesOption3) {
          // 다른 선택란에 동일한 값이 있는지 체크
          if (!licensesinsert1.includes(licensesOption3) && !licensesinsert2.includes(licensesOption3) && !licensesinsert3.includes(licensesOption3)) {
              licensesinsert3 += licensesOption3 + ",";
              $('#licenses3').val(licensesinsert3.slice(0, -1));
          } else {
              alert('이미 선택된 자격증입니다: ' + licensesOption3);
              $('#licensesOption3').val(''); // 선택란 초기화
          }
      }
  });
});
	 	 
</script>

<script>
$(function(){
	
	 $('#buttonclick').on('click',function(){
		 let licensessubmit='';
		 let option1= $('#licenses1').val();
		 let option2= $('#licenses2').val();
		 let option3= $('#licenses3').val();
		 
		 let optionList = option1 + "," + option2 + "," + option3;
		 $('#licenses').val(optionList);
		 
		 alert(optionList);
		 
	 })
})

</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>