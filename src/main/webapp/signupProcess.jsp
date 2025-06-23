<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="db.jsp" %>
<% 
    // 회원가입 폼에서 전달된 데이터를 변수에 저장
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String postcode = request.getParameter("postcode");
    String roadAddress = request.getParameter("roadAddress");
    String jibunAddress = request.getParameter("jibunAddress");
    String detailAddress = request.getParameter("detailAddress");
    String extraAddress = request.getParameter("extraAddress");

    // MySQL 데이터베이스에 연결하고 데이터를 삽입
    String sql = "INSERT INTO user (userid, password, username, email, zipcode, roadname_address, main_address, detail_address, reference_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = null;

    try {
        Class.forName(driverName);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, password);
        pstmt.setString(3, username);
        pstmt.setString(4, email);
        pstmt.setString(5, postcode);
        pstmt.setString(6, roadAddress);
        pstmt.setString(7, jibunAddress);
        pstmt.setString(8, detailAddress);
        pstmt.setString(9, extraAddress);

        int count = pstmt.executeUpdate();
        if (count == 1) {
%>
            <script type="text/javascript">
                location.href = "login.jsp";
                alert("회원가입에 성공하였습니다."); 
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("회원가입에 실패하였습니다.");
                location.href = "signup.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script type="text/javascript">
            alert("회원가입 중 오류가 발생했습니다: <%= e.getMessage() %>");
            location.href = "signup.jsp";
        </script>
<%
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
