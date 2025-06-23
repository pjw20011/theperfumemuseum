<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/header.css">
    <title>The Perfume Museum</title>
    <style>
    	
    </style>
</head>
<body>
	<div id="head">
	    <div class="header">
	        <h1><a href="index.jsp">The Perfume Museum</a></h1>
	    </div>
	    <div class="navbar">
        	<div class="menu-icon">&#9776;</div>	
	        <ul class="nav-links">
	            <li><a href="perfume.jsp">향수</a></li>
	            <li><a href="board.jsp">게시판</a></li>
	            <li><a href="dictionary.jsp">향수 사전</a></li>
	            <li><a href="perfumetest.jsp">향수 추천</a></li>
	            <li><a href="perfumeComparison.jsp">향수 비교</a></li>
	        </ul>
	        <div class="user-actions">
	            <%
				    // 세션에서 사용자 정보 가져오기
				    HttpSession index_session = request.getSession(false); // 기존 변수 이름 유지
				    String username = (String) session.getAttribute("username");
				
				    if (username != null) {
				        // 로그인된 경우
		        %>
		        <ul class="nav-links">
					<li>환영합니다 &nbsp;<%= username %>님!</li>
					<li id="mypage_li"><a href="mypage.jsp"><img src="image/user.png" alt="마이페이지"></a></li>
			        <li><a href="logout.jsp">로그아웃</a></li>
		        </ul>
		        <%
				    } else {
				        // 로그인 되어 있지 않은 경우
		         %>
					<a href="login.jsp">로그인</a>
				<%
				    }
				%>		
	
	        </div>
	    </div>
    </div>
</body>
</html>
