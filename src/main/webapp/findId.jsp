<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="background-image"></div>
    <div class="login-container">
        <h1>아이디 찾기</h1>
        <p>회원가입 시 입력한 이메일을 입력해주세요</p>
        <form action="findIdProcess.jsp" method="post">
            <div class="input-group">
                <label for="email">
                    <input type="email" id="email" name="email" placeholder="이메일을 입력하세요">
                </label>
            </div>
            <button type="submit">아이디 찾기</button>
        </form>
        <a href="login.jsp">로그인 페이지로 돌아가기</a>
    </div>
</body>
</html>
