<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    String comment_id = request.getParameter("comment_id");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 삭제할 댓글의 board_num을 가져오기
        String board_num = null;
        String sql = "SELECT board_num FROM comment WHERE comment_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, comment_id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            board_num = rs.getString("board_num");
        }

        if (board_num != null) {
            // 댓글 삭제
            sql = "DELETE FROM comment WHERE comment_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, comment_id);
            int result = pstmt.executeUpdate();

            if (result > 0) {
                // 댓글 수 감소
                sql = "UPDATE board SET comment = comment - 1 WHERE board_num = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, board_num);
                pstmt.executeUpdate();

                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Board number not found.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
%>
