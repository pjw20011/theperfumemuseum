<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfume Collection</title>
    <link rel="stylesheet" href="css/perfume.css">
    <style>
        .pagination {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #333;
        }

        .pagination a.active {
            background-color: #333;
            color: white;
        }

        .pagination a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    
    <div class="perfume-container">
        <div id="perfume-grid" class="perfume-grid">
            <!-- 향수 아이템 로드 -->
            <%
                String pageParam = request.getParameter("page");
                int currentPage = 1;
                int size = 16; // 페이지당 항목 수

                if (pageParam != null && !pageParam.isEmpty()) {
                    try {
                        currentPage = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }

                int offset = (currentPage - 1) * size;

                Connection dbConnection = (Connection) pageContext.getAttribute("dbConn");
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    String query = "SELECT `id`, `제품명`, `이미지url`, `브랜드명` FROM perfume LIMIT ? OFFSET ?";
                    pstmt = dbConnection.prepareStatement(query);
                    pstmt.setInt(1, size);
                    pstmt.setInt(2, offset);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("제품명");
                        String brand = rs.getString("브랜드명");
                        String imageUrl = rs.getString("이미지url");
            %>
                        <div class="perfume-item" data-id="<%= id %>">
                            <a href="perfumedetail.jsp?id=<%= id %>">
                                <img src="<%= imageUrl %>" alt="<%= name %>">
                                <div class="perfume-info">
                                    <h2><%= name %></h2>
                                    <p><%= brand %></p>
                                </div>
                            </a>
                        </div>
            <%
                    }

                    // 총 페이지 수 계산
                    String countQuery = "SELECT COUNT(*) FROM perfume";
                    PreparedStatement countPstmt = dbConnection.prepareStatement(countQuery);
                    ResultSet countRs = countPstmt.executeQuery();
                    int totalCount = 0;
                    if (countRs.next()) {
                        totalCount = countRs.getInt(1);
                    }
                    int totalPages = (int) Math.ceil(totalCount / (double) size);

                    countRs.close();
                    countPstmt.close();
            %>
        </div>
        
        <!-- 페이지 네비게이션 -->
        <div class="pagination">
            <%
                int pageGroupSize = 5;
                int currentGroup = (int) Math.ceil((double) currentPage / pageGroupSize);
                int startPage = (currentGroup - 1) * pageGroupSize + 1;
                int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

                if (startPage > 1) {
            %>
                <a href="perfume.jsp?page=<%= startPage - 1 %>">&laquo; 이전</a>
            <%
                }

                for (int i = startPage; i <= endPage; i++) {
                    if (i == currentPage) {
            %>
                        <a href="perfume.jsp?page=<%= i %>" class="active"><%= i %></a>
            <%
                    } else {
            %>
                        <a href="perfume.jsp?page=<%= i %>"><%= i %></a>
            <%
                    }
                }

                if (endPage < totalPages) {
            %>
                <a href="perfume.jsp?page=<%= endPage + 1 %>">다음 &raquo;</a>
            <%
                }
            %>
        </div>
        
        <%
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>
