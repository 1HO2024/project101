<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/html.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>면접 후기 게시판</title>
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
        .rating {
            font-size: 20px; /* 별 크기 조정 */
            color: gold; /* 채워진 별 색상 */
        }
        .empty-star {
            color: lightgray; /* 빈 별 색상 */
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/headerindi.jsp" %> 
<div class="div4">
<main>

<!-- Tab Menu -->
<div class="tab-menu">
    <a href="/picktalk/posts?user_id=${user_id}">자유 게시판</a>
    <a href="/picktalk/reviews?user_id=${user_id}" class="active">면접 후기 게시판</a>
</div>



<!-- 글쓰기 버튼 -->
<div class="write-btn">
    <a href="/picktalk/reviewForm?user_id=${user_id}">후기글쓰기</a>
</div>

<!-- 구분선 추가 -->
<hr style="border: 1px solid #ccc; margin: 20px 0;">


<div style="display: flex;">
    <input type="text" name="searchtext1" id="searchtext1" placeholder="기업명 검색" class="form-control me-2"/>
    <button id="search1" name="search" class="btn btn-primary">Search</button>
    <button type="reset" onclick='window.location.reload()'class="btn btn " style=" vertical-align: top;">⟳초기화</button>
</div>


<!-- 게시판 테이블 -->
<table class="table2">
    <tr>       
        <th>NO</th>
        <th>기업</th>
        <th>면접 후기 평점</th>
        <th>제목</th>
        <th>작성일</th>
        <th>상세보기</th>
    </tr>
    <tbody class ="reviewlist">
    <c:forEach var="review" items="${reviews}" varStatus="status">
        <tr>
            <td>${totalReviews - (currentPage - 1) * size - status.index}</td>
            <td>${review.compname}</td>
            <td>
                <div class="rating">
                    <c:forEach var="i" begin="1" end="5">
                        <c:if test="${i <= review.rating}">
                            <span>★</span>
                        </c:if>
                        <c:if test="${i > review.rating}">
                            <span class="empty-star">★</span> 
                        </c:if>
                    </c:forEach>
                </div>
            </td>
            <td>${review.title}</td>
            <td>${review.review_date}</td>
            <td>
                <a href="/picktalk/reviewDetail?review_id=${review.review_id}&user_id=${user_id}">상세보기</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</main>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
    $('#search1').on('click', function(event) {
        const compname = $('#searchtext1').val(); // 입력된 검색어 가져오기
        $.ajax({
            url: '/picktalk/search',
            type: 'GET',
            data: { compname: compname },
            success: function(response) {
                console.log(response); // 응답 내용 확인
                let html = '';
                let searchlist = response.searchlist;

                // 검색 결과가 없을 경우
                if (!searchlist || searchlist.length === 0) {
                    alert("검색된 기업의 후기가 없습니다.");
                } else {
                    // 이전 결과 지우기
                    $('.reviewlist').html(""); 

                    // 검색 결과가 있을 경우
                    searchlist.forEach(function(a, index) {
                       html += "<tr>"
                            + "<td>" + (searchlist.length - index) + "</td>" // NO: 검색된 리스트의 인덱스를 기반으로 계산
                            + "<td>" + a.compname + "</td>" // 기업명
                            + "<td>"
                            + "<div class='rating'>";
                            for (let i = 1; i <= 5; i++) {
                                if (i <= a.rating) {
                                    html += "<span>★</span>"; // 채워진 별
                                } else {
                                    html += "<span class='empty-star'>★</span>"; // 빈 별
                                }
                            }
                         html += "</div></td>"
                            + "<td>" + a.title + "</td>"
                            + "<td>" + a.review_date + "</td>"
                            
                            + "<td>"
                            + "<a href='/picktalk/reviewDetail?review_id="+a.review_id+"&user_id="+a.user_id+"'>"
                            + "상세보기<a></td>"
                            + "</tr>";
                    });

                    // 생성한 HTML을 .reviewlist에 추가
                    $('.reviewlist').html(html);
                }
            },
            error: function(xhr, status, error) {
                console.error("검색 중 오류 발생:", error);
            }
        });
    });
});
</script>
<%@ include file="/WEB-INF/views/include/ipagination.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
