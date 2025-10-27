<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<%@ taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pick Me</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #F5F6F8; 
        }  
        img {
            height: 200px; 
        }
        .button-container {
            display: flex;
            justify-content: space-between;
            width: 600px;
            height: 200px;
            margin: 50px;
        }
        .button {
            flex: 1; 
            margin:  10px; 
            padding: 10px; 
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            font-size: 25px; 
            transition: background-color 0.3s;
            background-color: #2759FF;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); 
    		box-sizing: border-box;
        } 
        .button:hover {
            background-color: #405DAB;
            transform: translateY(-5px);
    		box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); 
        }

    </style>
</head>
<body>
	<img src="/img/로고.png"  alt=회사로고 onclick="location.href='/'"/>
    <h2>어떤 회원 이신가요?</h2>
    <div class="button-container">
        <button class="button individual" onclick="location.href='/Individual/Signup'">개인 회원가입</button>
        <button class="button company" onclick="location.href='/Company/Signup'">기업 회원가입</button>        
    </div>
</body>
</html>
