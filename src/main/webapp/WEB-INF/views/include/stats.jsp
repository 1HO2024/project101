<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<table class="stats">
    <tr>
        <td>개인 회원 수: <c:out value="${totalUsers}" /></td>
        <td>기업 회원 수: <c:out value="${totalCompUsers}" /></td>
        <td>채용공고 수: <c:out value="${totalPost}" /></td>
    </tr>
</table>

 
 <script>
    console.log("개인 회원 수: ${totalUsers}");
    console.log("기업 회원 수: ${totalCompUsers}");
    console.log("채용공고 수: ${totalPost}");
</script>

</body>
</html>