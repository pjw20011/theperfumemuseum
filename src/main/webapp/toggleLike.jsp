<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ include file="db.jsp" %>

<%
    String num = request.getParameter("num");
    String clickUser = (String) session.getAttribute("username");

    boolean liked = false;
    int great = 0;

    if (clickUser != null && num != null) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 좋아요 여부 확인
            String checkSql = "SELECT * FROM boardgreat WHERE click_user = ? AND board_id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, clickUser);
            pstmt.setString(2, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 이미 좋아요를 누른 경우 -> 좋아요 취소
                String deleteSql = "DELETE FROM boardgreat WHERE click_user = ? AND board_id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setString(1, clickUser);
                pstmt.setString(2, num);
                pstmt.executeUpdate();

                // great 컬럼 감소
                String updateSql = "UPDATE board SET great = great - 1 WHERE board_num = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setString(1, num);
                pstmt.executeUpdate();

                liked = false;
            } else {
                // 좋아요를 누르지 않은 경우 -> 좋아요 추가
                String insertSql = "INSERT INTO boardgreat (click_user, board_id) VALUES (?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, clickUser);
                pstmt.setString(2, num);
                pstmt.executeUpdate();

                // great 컬럼 증가
                String updateSql = "UPDATE board SET great = great + 1 WHERE board_num = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setString(1, num);
                pstmt.executeUpdate();

                liked = true;
            }

            // 현재 great 수 가져오기
            String greatSql = "SELECT great FROM board WHERE board_num = ?";
            pstmt = conn.prepareStatement(greatSql);
            pstmt.setString(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                great = rs.getInt("great");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        }
    }

    response.setContentType("application/json");
    out.print("{\"liked\": " + liked + ", \"great\": " + great + "}");
%>
