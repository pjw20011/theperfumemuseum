<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfume Recommendation</title>
    <link rel="stylesheet" href="css/result.css">
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <main>
        <div class="result-container">
            <b>추천하는 당신의 향수는 ?? </b>
            <%
                String answer = request.getParameter("answer");
                String[] answers = answer.split(",");
                Map<String, Integer> countMap = new HashMap<>();
                for (String ans : answers) {
                    countMap.put(ans, countMap.getOrDefault(ans, 0) + 1);
                }
                
                String maxKey = Collections.max(countMap.entrySet(), Map.Entry.comparingByValue()).getKey();
                
                Connection dbConnection = (Connection) pageContext.getAttribute("dbConn");
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                try {
                    String query = "";
                    if ("%rose".equals(maxKey)) {
                        query = "SELECT `제품명`, `이미지url`, `브랜드명`, `탑노트`, `미들노트`, `베이스노트` FROM perfume WHERE `미들노트` LIKE ? ORDER BY RAND() LIMIT 5";
                    } else if ("%lemon".equals(maxKey)) {
                        query = "SELECT `제품명`, `이미지url`, `브랜드명`, `탑노트`, `미들노트`, `베이스노트` FROM perfume WHERE `탑노트` LIKE ? ORDER BY RAND() LIMIT 5";
                    } else if ("%wood".equals(maxKey)) {
                        query = "SELECT `제품명`, `이미지url`, `브랜드명`, `탑노트`, `미들노트`, `베이스노트` FROM perfume WHERE `베이스노트` LIKE ? ORDER BY RAND() LIMIT 5";
                    } else if ("%musk".equals(maxKey)) {
                        query = "SELECT `제품명`, `이미지url`, `브랜드명`, `탑노트`, `미들노트`, `베이스노트` FROM perfume WHERE `베이스노트` LIKE ? ORDER BY RAND() LIMIT 5";
                    }
                    
                    pstmt = dbConnection.prepareStatement(query);
                    pstmt.setString(1, "%" + maxKey + "%");
                    rs = pstmt.executeQuery();
                    
                    boolean firstResult = true;
                    while (rs.next()) {
                        String name = rs.getString("제품명");
                        String brand = rs.getString("브랜드명");
                        String imageUrl = rs.getString("이미지url");
                        String topNote = rs.getString("탑노트");
                        String middleNote = rs.getString("미들노트");
                        String baseNote = rs.getString("베이스노트");
                        
                        if (firstResult) {
            %>
                        <div class="perfume-recommendation large">
                            <img src="<%= imageUrl %>" alt="<%= name %>">
                            <h2><%= name %></h2>
                            <p><%= brand %></p>
                            <p><strong>탑노트:</strong> <%= topNote %></p>
                            <p><strong>미들노트:</strong> <%= middleNote %></p>
                            <p><strong>베이스노트:</strong> <%= baseNote %></p>
                        </div>
                        <div class="other-recommendations">
            <%
                            firstResult = false;
                        } else {
            %>
                            <div class="perfume-recommendation small">
                                <img src="<%= imageUrl %>" alt="<%= name %>">
                                <h3><%= name %></h3>
                                <p><%= brand %></p>
                            </div>
            <%
                        }
                    }
                    if (!firstResult) {
            %>
                        </div>
            <%
                    } else {
            %>
                        <p>추천할 향수를 찾을 수 없습니다.</p>
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
