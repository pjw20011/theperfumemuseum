<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>

<%
    // 세션 종료
    session.invalidate();

    // 메시지 출력 및 로그인 페이지 이동
%>
    <script type="text/javascript">
	    alert("로그아웃되었습니다.");
	    location.href = "index.jsp";// 로그인 페이지 URL
    </script>