<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="db.jsp" %>
<%
    String userid = request.getParameter("userid");
    String email = request.getParameter("email");

    String sql = "SELECT password FROM user WHERE userid = ? AND email = ?";

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName(driverName);
        conn = DriverManager.getConnection(url, dbusername, dbPassword);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, email);

        rs = pstmt.executeQuery();
        if (rs.next()) {
            String password = rs.getString("password");
%>
            <script type="text/javascript">
                alert("회원님의 비밀번호는 '<%= password %>' 입니다.");
                location.href = "login.jsp";
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("입력하신 정보로 등록된 계정이 없습니다.");
                location.href = "findPassword.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script type="text/javascript">
            alert("비밀번호 찾기 중 오류가 발생했습니다: <%= e.getMessage() %>");
            location.href = "findPassword.jsp";
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
