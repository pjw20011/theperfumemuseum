<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm-password");

    if (currentPassword == null || newPassword == null || confirmPassword == null) {
        out.println("<script>alert('모든 필드를 입력하세요.'); history.back();</script>");
        return;
    }

    if (!newPassword.equals(confirmPassword)) {
        out.println("<script>alert('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 현재 비밀번호 확인
        String sql = "SELECT password FROM user WHERE username = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String password = rs.getString("password");
            if (!password.equals(currentPassword)) {
                out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.'); history.back();</script>");
                return;
            }
        } else {
            out.println("<script>alert('사용자를 찾을 수 없습니다.'); history.back();</script>");
            return;
        }

        // 비밀번호 업데이트
        sql = "UPDATE user SET password = ? WHERE username = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, newPassword);
        pstmt.setString(2, username);

        int updated = pstmt.executeUpdate();
        if (updated > 0) {
            session.invalidate(); // 세션 무효화 (로그아웃)
            out.println("<script>alert('비밀번호가 성공적으로 변경되었습니다. 다시 로그인 해주세요.'); location.href='login.jsp';</script>");
        } else {
            out.println("<script>alert('비밀번호 변경에 실패하였습니다.'); history.back();</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생하였습니다.'); history.back();</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
