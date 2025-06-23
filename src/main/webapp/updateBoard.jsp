<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    String num = request.getParameter("num");
    String subject = request.getParameter("subject");
    String content = request.getParameter("content");

    PreparedStatement pstmt = null;

    try {
        String sql = "UPDATE board SET subject = ?, content = ? WHERE board_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, subject);
        pstmt.setString(2, content);
        pstmt.setString(3, num);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.sendRedirect("board_view.jsp?num=" + num);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "게시글 수정에 실패했습니다.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
%>
