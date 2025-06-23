<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="db.jsp" %>
<%
    String subject = request.getParameter("subject");
    String content = request.getParameter("content");
    String writer = (String) session.getAttribute("username");
    
    if (writer == null) {
        out.println("<script>alert('로그인 상태가 아닙니다.'); location.href='login.jsp';</script>");
        return;
    }

    String date = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    int view = 0;
    int great = 0;

    String sql = "INSERT INTO board (subject, content, writer, date, view, great) VALUES (?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = null;

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, subject);
        pstmt.setString(2, content);
        pstmt.setString(3, writer);
        pstmt.setString(4, date);
        pstmt.setInt(5, view);
        pstmt.setInt(6, great);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('글이 성공적으로 작성되었습니다.'); location.href='board.jsp';</script>");
        } else {
            out.println("<script>alert('글 작성에 실패했습니다.'); history.back();</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('글 작성 중 오류가 발생했습니다.'); history.back();</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
