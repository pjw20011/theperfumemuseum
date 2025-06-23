<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfume Detail</title>
    <link rel="stylesheet" href="css/perfumedetail.css">
    <style>
        
    </style>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <main>
        
        <div class="perfume-detail-container">
	        
            <%
                String perfumeId = request.getParameter("id");
                Connection dbConnection = (Connection) pageContext.getAttribute("dbConn");
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    String query = "SELECT `제품명`, `이미지url`, `브랜드명`, `탑노트`, `미들노트`, `베이스노트` FROM perfume WHERE id = ?";
                    pstmt = dbConnection.prepareStatement(query);
                    pstmt.setString(1, perfumeId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String name = rs.getString("제품명");
                        String brand = rs.getString("브랜드명");
                        String imageUrl = rs.getString("이미지url");
                        String topNote = rs.getString("탑노트");
                        String middleNote = rs.getString("미들노트");
                        String baseNote = rs.getString("베이스노트");
            %>
                        <div class="perfume-detail">
                        <div class="back-button" onclick="history.back()">
				            <img src="image/arrow-left.png" alt="Back">
				        </div>
                            <img src="<%= imageUrl %>" alt="<%= name %>">
                            <div class="perfume-info">
                                <h1><%= name %></h1>
                                <h2><%= brand %></h2>
                                <p><strong>탑노트:</strong> <%= topNote %></p>
                                <p><strong>미들노트:</strong> <%= middleNote %></p>
                                <p><strong>베이스노트:</strong> <%= baseNote %></p>
                            </div>
                        </div>
            <%
                    } else {
            %>
                        <p>해당 향수를 찾을 수 없습니다.</p>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    // dbConnection은 닫지 않음
                }
            %>
        </div>
    </main>
</body>
<%@ include file="footer.jsp" %>
</html>
