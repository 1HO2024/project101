<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .green { color:green; }
  .red   { color:red; }
</style>

<script src="https://cdn.jsdelivr.net/npm/browser-scss@1.0.3/dist/browser-scss.min.js"></script>

</head>
<body>
  <main>
   <form action="/Individual/DupCheck" method="post">
    <h2>Id 중복확인</h2>
    <input type="text"    name="user_id" value="${ param.user_id }" />
    <input type="submit"  value="검색" /> 
   </form>
   <div style="height:20px;"></div>
   <c:choose>
    <c:when test="${ CompanyVo eq null }">
     <p class="green">
      ${ param.user_id }는 사용가능한 아이디입니다
      <input type="button" id="btnClose" value="ID 사용하기" /> 
     </p>
    </c:when>
    <c:otherwise>
     <p class="red">${ param.user_id }는 사용할 수 없는 아이디입니다</p>
    </c:otherwise>
   </c:choose>
  </main>   
  
  <script>
     const  btnCloseEl = document.getElementById('btnClose')
     btnCloseEl.onclick = function() {
        // 넘겨줄 창의 user_id 에 조회괸 결과를 보낸다
        // 넘겨줄 창(내창을 open한 window) : window.opener -> mf
        // 내창 : window                                   -> cf
        const  mfuser_idEl =  window.opener.document.querySelector('[name=user_id]');
        const  cfuser_idEl =  window.document.querySelector('[name=user_id]')
        mfuser_idEl.value  =  cfuser_idEl.value;
        window.close();
     }
  
  </script>
</body>
</html>







