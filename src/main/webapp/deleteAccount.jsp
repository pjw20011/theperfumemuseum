<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Delete Account</title>
    <link rel="stylesheet" href="css/mypage.css">
    <script>
        function showAlertAndRedirect() {
            alert('계정이 삭제되었습니다.');
            window.location.href = 'index.jsp';
        }
    </script>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <div class="container">
        <h1>회원탈퇴</h1>
        <%
            if (session == null || session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                PreparedStatement pstmt = null;

                try {
                    String sql = "DELETE FROM user WHERE username = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.executeUpdate();
                    session.invalidate();
        %>
                    <script>
                        showAlertAndRedirect();
                    </script>
        <%
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>회원탈퇴 중 오류가 발생했습니다.</p>");
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                }
            } else {
        %>
                <form method="post" action="deleteAccount.jsp">
                    <label for="password">비밀번호:</label>
                    <input type="password" id="password" name="password" required>
                    <button type="submit">탈퇴</button>
                </form>
        <%
            }
        %>
    </div>
</body>
</html>
