<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    String post_id = request.getParameter("post_id");

    PreparedStatement pstmt = null;

    try {
        // 댓글 삭제
        String sql = "DELETE FROM comment WHERE board_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, post_id);
        pstmt.executeUpdate();
        pstmt.close();

        // 게시글 삭제
        sql = "DELETE FROM board WHERE board_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, post_id);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
%>
