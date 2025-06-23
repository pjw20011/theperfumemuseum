<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String newUsername = request.getParameter("username");
    String email = request.getParameter("email");
    String zipcode = request.getParameter("zipcode");
    String roadnameAddress = request.getParameter("roadname_address");
    String mainAddress = request.getParameter("main_address");
    String detailAddress = request.getParameter("detail_address");
    String referenceAddress = request.getParameter("reference_address");

    PreparedStatement pstmt = null;

    try {
        String sql = "UPDATE user SET username=?, email=?, zipcode=?, roadname_address=?, main_address=?, detail_address=?, reference_address=? WHERE username=?";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, newUsername);
        pstmt.setString(2, email);
        pstmt.setString(3, zipcode);
        pstmt.setString(4, roadnameAddress);
        pstmt.setString(5, mainAddress);
        pstmt.setString(6, detailAddress);
        pstmt.setString(7, referenceAddress);
        pstmt.setString(8, username);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("username", newUsername);
%>
            <script type="text/javascript">
                alert("사용자 정보가 성공적으로 업데이트 되었습니다.");
                location.href = "mypage.jsp?section=editProfile";
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("사용자 정보 업데이트에 실패했습니다.");
                location.href = "mypage.jsp?section=editProfile";
            </script>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
%>
        <script type="text/javascript">
            alert("사용자 정보 업데이트 중 오류가 발생했습니다: <%= e.getMessage() %>");
            location.href = "mypage.jsp?section=editProfile";
        </script>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
