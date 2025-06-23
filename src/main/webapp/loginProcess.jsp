<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="db.jsp" %>
<% 
    // 로그인 폼에서 전달된 데이터를 변수에 저장
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");

    // MySQL 데이터베이스에 연결하고 로그인 확인
    String sql = "SELECT userid, password, username FROM user WHERE userid = ? AND password = ?";

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName(driverName);
        conn = DriverManager.getConnection(url, dbusername, dbPassword);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();
        if (rs.next()) {
            String username = rs.getString("username");
            session.setAttribute("username", username);
%>
            <script type="text/javascript">
                alert("로그인에 성공하였습니다.");
                location.href = "index.jsp"; // 로그인 성공 후 이동할 페이지
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("로그인에 실패하였습니다. 아이디와 비밀번호를 확인하세요.");
                location.href = "login.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script type="text/javascript">
            alert("로그인 중 오류가 발생했습니다: <%= e.getMessage() %>");
            location.href = "login.jsp";
        </script>
<%
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
