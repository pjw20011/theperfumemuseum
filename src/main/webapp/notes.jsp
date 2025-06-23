<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    Statement stmt = null;
    ResultSet rs = null;
    String searchQuery = request.getParameter("search");
    searchQuery = searchQuery != null ? searchQuery : "";

    try {
        stmt = conn.createStatement();
        String sql = "SELECT 노트분류, 노트명, 이미지 FROM perfumenote";
        if (!searchQuery.isEmpty()) {
            sql += " WHERE 노트명 LIKE '%" + searchQuery + "%'";
        }
        rs = stmt.executeQuery(sql);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Perfume Notes</title>
    <link rel="stylesheet" href="css/notes.css">
</head>
<body>
	<header>
		<%@ include file="header.jsp" %>
	</header>

    <div class="container">
    	<a href="dictionary.jsp" class="back-button"><img src="image/arrow-left.png"></a>
        <h1>Perfume Notes</h1>
        <div class="search-bar">
            <form action="notes.jsp" method="get">
                <input type="text" name="search" placeholder="노트를 검색하세요..." value="<%= searchQuery %>">
                <button type="submit">검색</button>
            </form>
        </div>

        <div id="note-box">
            <%
                String currentCategory = "";
                boolean notesFound = false;
                while (rs.next()) {
                    notesFound = true;
                    String category = rs.getString("노트분류");
                    String name = rs.getString("노트명");
                    String imageUrl = rs.getString("이미지");
        
                    if (!category.equals(currentCategory)) {
                        if (!currentCategory.equals("")) {
                            out.println("</div>");
                        }
                        currentCategory = category;
                        out.println("<div class='note-category'>" + category + "</div>");
                        out.println("<div class='notes'>");
                    }
            %>
                    <div class="note">
                        <img src="<%= imageUrl %>" alt="<%= name %>">
                        <div class="note-name"><%= name %></div>
                    </div>
            <%
                }
                if (!currentCategory.equals("")) {
                    out.println("</div>");
                }
                if (!notesFound) {
                    out.println("<p>검색 결과가 없습니다.</p>");
                }
            %>
        </div>
    </div>

</body>
<%@ include file="footer.jsp" %>
</html>

<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
