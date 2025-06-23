<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="background-image"></div>
    <div class="login-container">
        <a id="home_logo" href="index.jsp"><img src="image/home.png" alt="메인화면 이동"></a>
        <h1>로그인</h1>
        <p>계정이 있으시다면 로그인을 해주세요</p>
        <form action="loginProcess.jsp" name="login" method="post">
            <div class="input-group">
                <label for="userid">
                    <input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요">
                </label>
            </div>
            <div class="input-group">
                <label for="password">
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">
                </label>
            </div> 
            <button type="submit">로그인</button>
        </form>
        <p class="signup-text">계정이 없으시다면?&nbsp;&nbsp;<a href="signup.jsp">여기를 클릭해주세요!</a></p>
        <p class="forgot-text"><a href="findId.jsp">아이디 찾기</a> | <a href="findPassword.jsp">비밀번호 찾기</a></p>
    </div>
</body>
</html>
