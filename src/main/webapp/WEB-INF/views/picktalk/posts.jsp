<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>자유 게시판</title>
    <style>
        .tab-menu {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }
        .tab-menu a {
            padding: 10px 20px;
            text-decoration: none;
            color: black;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 0 5px;
            background-color: #f9f9f9;
            transition: background-color 0.3s, color 0.3s;
        }
        .tab-menu a.active {
            background-color: #007bff;
            color: white;
        }
        .tab-menu a:hover {
            background-color: #0056b3;
            color: white;
        }
        .write-btn {
            display: block;
            margin: 20px auto;
            text-align: center;
        }
        .write-btn a {
            padding: 10px 20px;
            text-decoration: none;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .write-btn a:hover {
            background-color: #218838;
        }
        .table2 {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        .table2 th, .table2 td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        .table2 th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/headerindi.jsp" %> 
<div class="div4">
<main>

<!-- Tab Menu -->
<div class="tab-menu">
    <a href="/picktalk/posts?user_id=${user_id}" class="active">자유 게시판</a>
    <a href="/picktalk/reviews?user_id=${user_id}">면접 후기 게시판</a>
</div>

<!-- 글쓰기 버튼 -->
<div class="write-btn">
    <a href="/picktalk/postForm?user_id=${user_id}">자유글쓰기</a>
</div>

<!-- 구분선 추가 -->
<hr style="border: 1px solid #ccc; margin: 20px 0;">

<!-- 게시판 테이블 -->
    <table class="table2">
        <tr>        	
            <th>NO</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th></th>
        </tr>
        <c:forEach var="post" items="${posts}" varStatus="status">
            <tr>
                <td>${totalPosts - (currentPage - 1) * size - status.index}</td>
                <td>${post.title}</td>
                <td>${post.user_id}</td>
                <td>${post.vcount}</td>
                <td>
                    <a href="/picktalk/posts/${post.post_id}?user_id=${user_id}">상세보기</a>
                </td>
            </tr>
        </c:forEach>     
    </table>
</main>
</div>

<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
