<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Perfume Comparison</title>
    <link rel="stylesheet" href="css/perfumeComparison.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css">
    <style>
        .select2-container .select2-results__option img {
            width: 50px;
            height: auto;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <div class="container">
        <form action="perfumeComparison.jsp" method="get" class="form-container">
            <div class="item">
                <label for="perfume1">향수 1:</label>
                <select name="perfume1" id="perfume1" class="perfume-select">
                    <%
                        Connection dbConnection = (Connection) pageContext.getAttribute("dbConn");
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            String query1 = "SELECT `id`, `제품명`, `이미지url` FROM perfume";
                            pstmt = dbConnection.prepareStatement(query1);
                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                                String id = rs.getString("id");
                                String name = rs.getString("제품명");
                                String imageUrl = rs.getString("이미지url");
                    %>
                                <option value="<%= id %>" data-image="<%= imageUrl %>"><%= name %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>
            <div class="item">
                <label for="perfume2">향수 2:</label>
                <select name="perfume2" id="perfume2" class="perfume-select">
                    <%
                        try {
                            String query2 = "SELECT `id`, `제품명`, `이미지url` FROM perfume";
                            pstmt = dbConnection.prepareStatement(query2);
                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                                String id = rs.getString("id");
                                String name = rs.getString("제품명");
                                String imageUrl = rs.getString("이미지url");
                    %>
                                <option value="<%= id %>" data-image="<%= imageUrl %>"><%= name %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>
            <button type="submit">비교하기</button>
        </form>

        <%
            String perfume1 = request.getParameter("perfume1");
            String perfume2 = request.getParameter("perfume2");
            if (perfume1 != null && perfume2 != null) {
                PreparedStatement pstmt1 = null;
                PreparedStatement pstmt2 = null;
                ResultSet rs1 = null;
                ResultSet rs2 = null;
                try {
                    String query = "SELECT `제품명`, `이미지url`, `탑노트`, `미들노트`, `베이스노트` FROM perfume WHERE id = ?";
                    pstmt1 = dbConnection.prepareStatement(query);
                    pstmt1.setString(1, perfume1);
                    rs1 = pstmt1.executeQuery();

                    pstmt2 = dbConnection.prepareStatement(query);
                    pstmt2.setString(1, perfume2);
                    rs2 = pstmt2.executeQuery();

                    if (rs1.next() && rs2.next()) {
                        String name1 = rs1.getString("제품명");
                        String imageUrl1 = rs1.getString("이미지url");
                        String topNote1 = rs1.getString("탑노트");
                        String middleNote1 = rs1.getString("미들노트");
                        String baseNote1 = rs1.getString("베이스노트");

                        String name2 = rs2.getString("제품명");
                        String imageUrl2 = rs2.getString("이미지url");
                        String topNote2 = rs2.getString("탑노트");
                        String middleNote2 = rs2.getString("미들노트");
                        String baseNote2 = rs2.getString("베이스노트");
        %>
                        <div class="comparison">
                            <div class="perfume">
                                <img src="<%= imageUrl1 %>" alt="<%= name1 %>">
                                <h2><%= name1 %></h2>
                                <p><strong>탑노트:</strong> <%= topNote1 %></p>
                                <p><strong>미들노트:</strong> <%= middleNote1 %></p>
                                <p><strong>베이스노트:</strong> <%= baseNote1 %></p>
                            </div>
                            <div class="perfume">
                                <img src="<%= imageUrl2 %>" alt="<%= name2 %>">
                                <h2><%= name2 %></h2>
                                <p><strong>탑노트:</strong> <%= topNote2 %></p>
                                <p><strong>미들노트:</strong> <%= middleNote2 %></p>
                                <p><strong>베이스노트:</strong> <%= baseNote2 %></p>
                            </div>
                        </div>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs1 != null) try { rs1.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (rs2 != null) try { rs2.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt1 != null) try { pstmt1.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt2 != null) try { pstmt2.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script>
        $('.perfume-select').select2({
            templateResult: formatState,
            templateSelection: formatState
        });

        function formatState (state) {
            if (!state.id) {
                return state.text;
            }
            var baseUrl = state.element.dataset.image;
            var $state = $(
                '<span><img src="' + baseUrl + '" class="img-flag" /> ' + state.text + '</span>'
            );
            return $state;
        };
    </script>
</body>
<%@ include file="footer.jsp" %>
</html>
