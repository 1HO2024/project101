<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

 <%@ include file="/WEB-INF/views/include/headerindi.jsp" %>
    
     <div class= "div6">
       <main class ="main">
         <form action="/Individual/Cswrite?user_id=${param.user_id}"  method="POST">
         <table>
           <h2 style=text-align:center;>문의글 작성</h2>
     	   <tr>
     	     <th><span class="red">*</span>문의 구분</th>
     	     <td>
      	      <select name="type" >
      	       <option value="로그인">로그인</option>
      	       <option value="회원정보">회원정보</option>
      	       <option value="이력서">이력서</option>
      	       <option value="입사지원">입사지원</option>
      	       <option value="채용정보">채용정보</option>
      	       <option value="기타">기타</option>
      	      </select>
      	     </td>
     	   </tr>
     	   <tr>
      		 <th><span class="red">*</span>제목</th>
      		 <td><input type="text" name="csp_title" required/></td>
     	   </tr>
     	   <tr>
      		 <th>비밀번호</th>
      		 <td><input type= "text" name="csp_pw" id="csp_pw" readonly /></td>
      		 <td><input type="checkbox" id="goEdit" /><label for="goEdit">비밀글</label></td>
     	   </tr> 
     	   <tr>
       		 <th><span class="red">*</span>내용</th>
      		 <td><input type="text" name="content" required/></td>
     	   </tr>
     	   <tr>
      		 <th>문의 파일</th>
      		 <td><input class="input-field" type="text" name="csp_file" placeholder="파일을 업로드해주세요"/></td>
      		 <td><input class="test" type="file" value="파일첨부"></td>
     	   </tr>
     	   <tr>
      		 <th><span class="red">*</span>답변받을 이메일</th>
      		 <td><input type="email" name="email" required/></td>
     	   </tr>

     	   <tr>
      		 <td colspan="3">
      		   <input type="button" value="이전" id="goMain" class="btn btn-outline-primary" />
      		   <input type="submit" value="작성" class="btn btn-outline-success"/>
      		 </td>
     	   </tr>

     	   
     	 </table>    
     	 </form>
  
      <script>
         const goMain      = document.getElementById('goMain')
  			goMain.onclick    = function() {
  				location.href = '/Individual/Cslist?user_id=${sessionScope.login.user_id}'
  			}  

         const csp_pw = document.getElementById('csp_pw')
         const goEdit = document.getElementById('goEdit')
         const form   = document.querySelector('form')
         
         goEdit.onchange = function() {
             if (goEdit.checked) {
                csp_pw.removeAttribute('readonly');
                csp_pw.setAttribute('required', 'required'); 
             } else {
                csp_pw.setAttribute('readonly', 'readonly'); 
                csp_pw.removeAttribute('required'); 
                csp_pw.value = '';
             }
          };
          form.onsubmit = function(event) {
              if (goEdit.checked && csp_pw.value.trim() === '') {
                 alert("비밀글로 설정된 경우, 비밀번호를 입력해주세요.");
                 csp_pw.focus();
                 event.preventDefault(); 
              }
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
</script>
       </main>  
      
     </div>
     
     <!-- 공간띄우기 -->
     <div class= "space">
       <tr><br><br></tr>
     </div>
  
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>