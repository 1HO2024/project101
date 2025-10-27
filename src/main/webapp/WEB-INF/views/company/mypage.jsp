<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<title>Insert title here</title>

<body>

<%@ include file="/WEB-INF/views/include/headercomp.jsp" %>
    
     <!--메인화면 -->
     <div class= "div6">
       <main class ="main">
        <iframe name="hidden_iframe" style="display:none;"></iframe>
         <form action="/Company/Update"  method="POST" target="hidden_iframe">
         <table>
           <h2 style=text-align:center;>기업회원정보 수정</h2>
     	   <tr>
      		 <th>사용자 아이디</th>
      	     <td><input type="text" name="user_id"  value="${vo.user_id}" readonly /></td>
     	   </tr>
     	   <tr>
      		 <th><span class="red">*</span>비밀번호</th>
      		 <td><input type="password" name="password" id="passwd1" required /></td>
     	   </tr>
     	   <tr>
      		 <th><span class="red">*</span>비밀번호 확인</th>
      		 <td><input type="password" id="passwd2" /></td>
     	   </tr> 
     	   <tr>
       		 <th><span class="red">*</span>사용자 이름</th>
      		 <td><input type="text" name="username" value="${vo.username}" /></td>
     	   </tr>
     	   <tr>
      		 <th>기업명</th>
      		 <td><input type="text" name="compname" id="compname" value="${vo.compname}" readonly /></td>
     	   </tr>
     	   <tr>
      		 <th>이메일</th>
      		 <td><input type="email" name="email" value="${vo.email}" /></td>
     	   </tr>
     	   <tr>
      		 <th>전화번호</th>
      		 <td><input type="text" name="phone_number" value="${vo.phone_number}" /></td>
     	   </tr>
     	   <tr>
      		 <th>가입일</th>
      		 <td><input type="text" name="j_date" value="${vo.j_date}" readonly /></td>
     	   </tr>

     	   <tr>
      		 <td colspan="2">
      		   <input type="button" value="이전" id="goMain" class="btn btn-outline-primary" />
      		   <input type="submit" value="수정" id="submit" class="btn btn-outline-warning" />
      		   <input type="button" value="회원탈퇴" id="goDelete" class="btn btn-outline-danger"/>
      		 </td>
     	   </tr>

     	   
     	 </table>    
     	 </form>
   <script>
           const goMain      = document.getElementById('goMain')
           goMain.onclick    = function() {
              location.href = '/Company/Main?user_id=${vo.user_id}'
           }
            const  goDelete   = document.getElementById('goDelete')
           goDelete.onclick  = function() {
               const confirmed = confirm("정말로 회원 탈퇴를 하시겠습니까?")
               if(confirmed) {
                 location.href = '/Company/Delete?user_id=${vo.user_id}'
               }
          }    
            
            const form = document.querySelector("form");
            form.onsubmit = function(event) {
                const password = form.password.value;
                const confirmPassword = form.passwd2.value;

                if (password !== confirmPassword) {
                    event.preventDefault(); // 폼 제출 방지
                    alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요."); // 오류 메시지
                }else {
                  // 비밀번호가 일치할 경우에만 수정 완료 알림 표시
                  setTimeout(function() {
                      alert("수정이 완료되었습니다.");
                  }, 500);
              }
            }
            
            
         </script>  
       </main>      
     </div>
     <script>     
     $(function() {
           const emailEl = document.querySelector('[name=email]');
           const originalEmail = '${vo.email}';

           emailEl.addEventListener('blur', function() { 
               const email = emailEl.value.trim();
               if (email === '') return; 

               $.ajax({
                   url: '/Company/EmailDupCheck',
                   data: { email: email, originalEmail: originalEmail }, 
                   method: 'GET' 
               })
               .done(function(data) {
                   console.log(data);
                   if (data == null || data == '') { 
                       $('#dupResultEmail').html('사용 가능한 이메일입니다').addClass('green');
                   } else { 
                       $('#dupResultEmail').html('중복된 이메일입니다').addClass('red');
                       alert('중복된 이메일은 사용이 불가능합니다.'); 
                   }
               })
               .fail(function(err) {
                   console.log(err);
                   alert('오류: 다시 시도해주세요.');
               });
           });
       });
</script>

     <!-- 공간띄우기 -->
     <div class= "space">
       <tr><br><br></tr>
     </div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>