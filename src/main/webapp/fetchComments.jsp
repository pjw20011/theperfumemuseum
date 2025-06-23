<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="db.jsp" %>

<%
    String boardNum = request.getParameter("num");
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT * FROM comment WHERE board_num = ? ORDER BY comment_date DESC";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, boardNum);
        rs = pstmt.executeQuery();

        while (rs.next()) {
%>
            <div class="comment">
                <p>작성자: <%= rs.getString("comment_write") %> 작성일: <%= rs.getString("comment_date") %></p>
                <p><%= rs.getString("comment_content") %></p>
            </div>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
%>
