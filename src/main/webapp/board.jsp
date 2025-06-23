<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // 세션에서 사용자 이름 확인
    String board_session = (String) session.getAttribute("username");
    
    // 페이지 번호
    int pageNum = 1;
    if (request.getParameter("pageNum") != null) {
        pageNum = Integer.parseInt(request.getParameter("pageNum"));
    }
    int pageSize = 10;
    int offset = (pageNum - 1) * pageSize;

    // 검색어
    String searchKeyword = request.getParameter("search") != null ? request.getParameter("search") : "";

    // DB 연결
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, Object>> boardList = new ArrayList<>();
    int totalPages = 0;  // totalPages 변수 초기화

    try {
        String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM board WHERE subject LIKE ? ORDER BY date DESC LIMIT ? OFFSET ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + searchKeyword + "%");
        pstmt.setInt(2, pageSize);
        pstmt.setInt(3, offset);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> board = new HashMap<>();
            board.put("num", rs.getInt("board_num"));
            board.put("subject", rs.getString("subject"));
            board.put("writer", rs.getString("writer"));
            board.put("date", rs.getString("date"));
            board.put("comment", rs.getString("comment"));
            board.put("view", rs.getInt("view"));
            board.put("great", rs.getInt("great"));
            boardList.add(board);
        }

        rs.close();
        pstmt.close();

        // 총 게시글 수 가져오기
        sql = "SELECT FOUND_ROWS()";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        rs.next();
        int totalRecords = rs.getInt(1);
        totalPages = (int) Math.ceil(totalRecords / (double) pageSize);

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <link rel="stylesheet" href="css/board.css">
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <main>
        <section class="notice">
            <div class="page-title">
                <div class="container">
                    <h3>자유 게시판</h3>
                </div>
            </div>
            <!-- board search area -->
            <div id="board-search">
                <div class="container">
                    <div class="search-window">
                        <form method="get" action="board.jsp">
                            <div class="search-wrap">
                                <input id="search" type="search" name="search" placeholder="검색어를 입력해주세요." value="<%= searchKeyword %>">
                                <button type="submit" class="btn btn-dark">검색</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- board list area -->
            <div id="board-list">
                <div class="container">
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th class="th-num">번호</th>
                                <th class="th-title">제목</th>
                                <th class="th-writer">작성자</th>
                                <th class="th-date">등록일</th>
                                <th class="th-view">조회수</th>
                                <th class="th-great"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Map<String, Object> board : boardList) {
                            %>
                            <tr>
                                <td class="td-num"><%= board.get("num") %></td>
                                <td class="td-title">
                                    <a href="board_view.jsp?num=<%= board.get("num") %>"><%= board.get("subject") %></a>
                                </td>
                                <td class="td-writer"><%= board.get("writer") %></td>
                                <td class="td-date"><%= board.get("date") %></td>
                                <td class="td-view"><%= board.get("view") %></td>
                                <td class="td-great">❤️ <%= board.get("great") %>&nbsp;&nbsp;💬&nbsp;&nbsp;<%= board.get("comment") %></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- pagination area -->
            <div class="board-footer">
                <div class="container">
                    <% if (board_session != null) { %>
                        <a href="board_write.jsp" class="btn" id="write_btn">✏️글쓰기</a>
                    <% } %>
                    <div class="pagination">
                        <% if (pageNum > 1) { %>
                            <a href="board.jsp?pageNum=<%= pageNum - 1 %>&search=<%= searchKeyword %>" class="prev">&laquo; 이전</a>
                        <% } else { %>
                            <span class="prev disabled">&laquo; 이전</span>
                        <% } %>
                        <%
                            int startPage = Math.max(1, pageNum - 2);
                            int endPage = Math.min(totalPages, pageNum + 2);
                            if (startPage > 1) {
                        %>
                            <a href="board.jsp?pageNum=1&search=<%= searchKeyword %>">1</a>
                            <% if (startPage > 2) { %>
                                <span>...</span>
                            <% } %>
                        <%
                            }
                            for (int i = startPage; i <= endPage; i++) {
                                if (i == pageNum) {
                        %>
                            <a href="board.jsp?pageNum=<%= i %>&search=<%= searchKeyword %>" class="active"><%= i %></a>
                        <%
                                } else {
                        %>
                            <a href="board.jsp?pageNum=<%= i %>&search=<%= searchKeyword %>"><%= i %></a>
                        <%
                                }
                            }
                            if (endPage < totalPages) {
                        %>
                            <% if (endPage < totalPages - 1) { %>
                                <span>...</span>
                            <% } %>
                            <a href="board.jsp?pageNum=<%= totalPages %>&search=<%= searchKeyword %>"><%= totalPages %></a>
                        <%
                            }
                        %>
                        <% if (pageNum < totalPages) { %>
                            <a href="board.jsp?pageNum=<%= pageNum + 1 %>&search=<%= searchKeyword %>" class="next">다음 &raquo;</a>
                        <% } else { %>
                            <span class="next disabled">다음 &raquo;</span>
                        <% } %>
                    </div>
                </div>
            </div>
        </section>
    </main>
</body>
<%@ include file="footer.jsp" %>
</html>
