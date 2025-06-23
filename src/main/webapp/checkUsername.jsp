<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
    String userid = request.getParameter("userid");
    String sql = "SELECT COUNT(*) FROM user WHERE userid = ?";
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean isAvailable = true;

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            if (count > 0) {
                isAvailable = false;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    if (isAvailable) {
        out.print("available");
    } else {
        out.print("unavailable");
    }
%>
