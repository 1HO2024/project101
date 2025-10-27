<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<%@ taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="/css/common2.css" />
    <title>개인 회원가입</title>
    <script src="https://code.jquery.com/jquery.min.js"></script>

</head>
<body>
   <img src="/img/로고.png"  alt=회사로고 onclick="location.href='/'"/>
    <div class="container">
   <h2>개인 회원 가입</h2>
        <input type="button" class="inbtn" onclick="location.href='/Individual/Signup'" value="개인회원가입" style="width: 300px;"/>
        <input type="button" class="cobtn"onclick="location.href='/Company/Signup'" value="기업회원가입" style="width: 190px; background-color: #405DAB;"/>
        <form action="/Individual/SignupForm" method="POST">
            <table>
                <tr>
                    <td colspan="2">
                    <input type="text" name="user_id" placeholder="*아이디" required />
                    <input type="button" id="dupCheck" value="중복확인" style="width: 100%;"/>
                    <span id="dupResult"></span>
                    </td>
                </tr>
                <tr>
                   <td colspan="2">
                    <input type="password" name="password" id="password" placeholder="*비밀번호" required />
                    </td>
                </tr>
                <tr>
                   <td colspan="2">
                    <input type="password" name="passwordCheck" id="passwordCheck" placeholder="*비밀번호 확인" required/>
                    </td>
                </tr>
                <tr>
                   <td colspan="2">
                    <input type="text" name="username" placeholder="*이름" required />
                    </td>
                </tr>
                <tr>
                   <td colspan="2">
                    <input type="email" name="email" placeholder="*이메일" required/>
                    <span id="dupResultEmail"></span>
                    </td>
                </tr>
                <tr>
                   <td colspan="2">
                    <input type="text" name="phone_number" placeholder="전화번호"  />
                    </td>
                </tr>
                <tr>
                   <td colspan="2">
                    <input type="text" name="address" placeholder="주소" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="가입하기" id=""/>
                        <input type="button" value="돌아가기" id="goLogin" />
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <script>
       let   dupCheckClicked = false;     
       
       document.getElementById('goLogin').onclick = function() {
           location.href = '/Individual/Login';
       };
       
       const  formEl          = document.querySelector('form');
       const  user_idEl       = document.querySelector('[name=user_id]');
       const  emailEl        = document.querySelector('[name=email]');
       const  passwordEl        = document.querySelector('#password');
       const  passwordCheckEl = document.querySelector('#passwordCheck');
       const  usernameEl        = document.querySelector('[name=username]');
       const  dupCheckEl      = document.querySelector('#dupCheck');
       const  phoneNumberEl   = document.querySelector('[name=phone_number]');

       dupCheckEl.onclick = function() {
          dupCheckClicked = true;  
       }
       
       
       formEl.onsubmit   = function () {
          const  phoneNumber     = phoneNumberEl.value.trim();
           const  phonePattern    = /^(\d{3}-\d{4}-\d{4}|\d{3}\d{8})$/;
          
           if (user_idEl.value.trim().length < 4) {
               alert('아이디를 입력하세요. 아이디는 4자 이상 입력해야 합니다.');
               user_idEl.focus();
               return false;
           } 
           if (passwordEl.value.trim().length < 4) {
               alert('비밀번호를 입력하세요. 비밀번호는 4자이상 입력해야 합니다.');
               passwordEl.focus();
               return false;
           }
           if (passwordCheckEl.value.trim() === '') {
               alert('비밀번호 확인을 입력하세요');
               passwordCheckEl.focus();
               return false;
           }          
           if( passwordEl.value !== passwordCheckEl.value ) {
              alert('비밀번호가 일치하지 않습니다')
               passwordCheckEl.focus()
              return  false;
           }
           if( usernameEl.value.trim().length < 2 ) {
              alert('이름은 두자 이상 입력하세요')
               usernameEl.focus()
              return  false;
         }   
           if (emailEl.value.trim() === '') {
               alert('이메일을 입력하세요');
               emailEl.focus();
               return false;
           }
           if(  dupCheckClicked === false ) {
              alert('중복확인을 하세요')
               return false;
           }
           if (phoneNumber !== '' && !phonePattern.test(phoneNumber)) {
               alert('전화번호 형식이 올바르지 않습니다. (예: 000-0000-0000 또는 00011112222)');
               phoneNumberEl.focus();
               return false;
           }
           
           alert('회원가입이 완료되었습니다. 로그인을 해주세요.');
         return  true;
      };
    </script> 
    <script>
       $( function() {
           $('#dupCheck').on('click', function() {
              
              const user_id = $('[name=user_id]').val().trim();
               if (user_id === '') {
                   alert('아이디를 입력하세요'); 
                   $('[name=user_id]').focus(); 
                   return; 
               }
               if (user_id.length < 4) {
                   alert('아이디는 4자 이상 입력해야 합니다.');
                   $('[name=user_id]').focus();
                   return;
               }
               
                $.ajax({
                   url  : '/Individual/IdDupCheck',
                   data : { user_id : $('[name=user_id]').val()  }  
                  
               })
               .done( function( data ) { 
                   console.log(data)
                   if( data == '' ) {
                     let html = '사용가능한 아이디입니다'; 
                     dupCheckClicked = true;
                     $('#dupResult').html(html).addClass('green')
                   }  else  {  
                     let html = '사용할수 없는 아이디입니다'
                     dupCheckClicked = false;
                       $('#dupResult').html(html).addClass('red')
                   }
               })
               .fail( function(err) {
                   console.log(err)
                   alert('오류:다시 시도해주세요.');
               }) 
           })
       })     
    </script>
    <script>
    $(function() {
        emailEl.addEventListener('blur', function() { 
            const email = emailEl.value.trim();
            if (email === '') return; 

            $.ajax({
                url: '/Individual/EmailDupCheck',        // company 로 된거 individual 로 수정됨 !!
                data: { email: email }, 
                method: 'GET' 
            })
            .done(function(data) {
                console.log(data);
                if (data == null || data == '') { 
                    $('#dupResultEmail').html('사용 가능한 이메일입니다').addClass('green');
                } else { 
                    $('#dupResultEmail').html('중복된 이메일입니다').addClass('red');
                    alert('중복된 이메일입니다'); 
                }
            })
            .fail(function(err) {
                console.log(err);
                alert('오류: 다시 시도해주세요.');
            })
        })
    });
   </script>
</body>
</html>
