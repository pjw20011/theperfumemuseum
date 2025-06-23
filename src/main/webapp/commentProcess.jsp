<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.io.*" %>
<%@ include file="db.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String board_num = request.getParameter("board_num");
    String content = request.getParameter("content");
    String writer = (String) session.getAttribute("username");
    String comment_date = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

    PreparedStatement pstmt = null;

    try {
        // 댓글 삽입
        String sql = "INSERT INTO comment (comment_write, comment_content, comment_date, board_num) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, writer);
        pstmt.setString(2, content);
        pstmt.setString(3, comment_date);
        pstmt.setString(4, board_num);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 댓글 수 증가
            sql = "UPDATE board SET comment = comment + 1 WHERE board_num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, board_num);
            pstmt.executeUpdate();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true}");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to insert comment.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
%>
