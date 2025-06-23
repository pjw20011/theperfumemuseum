<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="db.jsp" %>
<%
    String email = request.getParameter("email");

    String sql = "SELECT userid FROM user WHERE email = ?";

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName(driverName);
        conn = DriverManager.getConnection(url, dbusername, dbPassword);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);

        rs = pstmt.executeQuery();
        if (rs.next()) {
            String userid = rs.getString("userid");
%>
            <script type="text/javascript">
                alert("회원님의 아이디는 '<%= userid %>' 입니다.");
                location.href = "login.jsp";
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("입력하신 이메일로 등록된 아이디가 없습니다.");
                location.href = "findId.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script type="text/javascript">
            alert("아이디 찾기 중 오류가 발생했습니다: <%= e.getMessage() %>");
            location.href = "findId.jsp";
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
