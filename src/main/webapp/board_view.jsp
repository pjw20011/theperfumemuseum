<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ include file="db.jsp" %>

<%
    String num = request.getParameter("num");
    String click_user = (String) session.getAttribute("username");
    Map<String, String> board = new HashMap<>();
    String sql = "SELECT * FROM board WHERE board_num = ?";
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    boolean liked = false; // 좋아요 상태 변수 추가

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, num);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            board.put("num", rs.getString("board_num"));
            board.put("subject", rs.getString("subject"));
            board.put("content", rs.getString("content"));
            board.put("writer", rs.getString("writer"));
            board.put("date", rs.getString("date"));
            board.put("view", rs.getString("view"));
            board.put("great", rs.getString("great"));
            board.put("comment", rs.getString("comment"));
        }

        // 조회수 증가
        sql = "UPDATE board SET view = view + 1 WHERE board_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, num);
        pstmt.executeUpdate();

        // 좋아요 상태 확인
        if (click_user != null) {
            sql = "SELECT * FROM boardgreat WHERE click_user = ? AND board_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, click_user);
            pstmt.setString(2, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                liked = true;
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="css/board_view.css">
    <script>
        const clickUser = "<%= click_user != null ? click_user : "" %>";
        const currentNum = "<%= num %>";

        function toggleHeart(num) {
            if (!clickUser) {
                alert("로그인 후 이용해 주세요.");
                return;
            }

            const heart = document.getElementById('heart');
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'toggleLike.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    document.getElementById('greatCount').innerText = response.great;
                    if (response.liked) {
                        heart.innerText = '❤️';
                    } else {
                        heart.innerText = '🖤';
                    }
                }
            };
            xhr.send('num=' + num);
        }

        function addComment(event) {
            event.preventDefault();

            const form = event.target;
            const formData = new URLSearchParams(new FormData(form)).toString();

            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'commentProcess.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        alert('댓글이 작성되었습니다.');
                        location.reload();
                    } else {
                        alert('댓글 작성에 실패했습니다.');
                    }
                } else {
                    alert('댓글 작성에 실패했습니다.');
                }
            };
            xhr.send(formData);
        }

        function deleteComment(commentId) {
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'deleteComment.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert('댓글이 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('댓글 삭제에 실패했습니다.');
                }
            };
            xhr.send('comment_id=' + commentId);
        }

        function deletePost(postId) {
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'deleteBoard.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert('게시글이 삭제되었습니다.');
                    window.location.href = 'board.jsp';
                } else {
                    alert('게시글 삭제에 실패했습니다.');
                }
            };
            xhr.send('post_id=' + postId);
        }
    </script>
    <style>
        .liked {
            color: red;
        }
        .comment {
            margin-bottom: 10px;
        }
        .delete-btn, .edit-btn {
            margin-left: 10px;
            color: red;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <article>
        <section id="detail-wrap">
            <table id="board-detail">
                <colgroup>
                    <col width="15%"/>
                    <col width="35%"/>
                    <col width="15%"/>
                    <col width="35%"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">글 번호</th>
                        <td><%= board.get("num") %></td>
                        <th scope="row">조회수</th>
                        <td><%= board.get("view") %></td>
                    </tr>
                    <tr>
                        <th scope="row">작성자</th>
                        <td><%= board.get("writer") %></td>
                        <th scope="row">작성일</th>
                        <td><%= board.get("date") %></td>
                    </tr>
                    <tr>
                        <th scope="row">제목</th>
                        <td colspan="3"><%= board.get("subject") %></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="content">
                            <%= board.get("content") %>
                            <div class="content-footer">
                                <div class="heart-container">
                                    <% if (click_user != null) { %>
                                        <span id="heart" onclick="toggleHeart(<%= num %>)" class="<%= liked ? "liked" : "" %>"><%= liked ? "❤️" : "🖤" %></span>
                                    <% } else { %>
                                        <span id="heart" class="disabled" title="로그인 후 이용해 주세요">🖤</span>
                                    <% } %>
                                    <span id="greatCount"><%= board.get("great") %></span>
                                </div>
                                <a href="board.jsp" class="btn">목록으로</a>
                                <% if (board.get("writer").equals(click_user)) { %>
                                    <span class="edit-btn" onclick="window.location.href='editBoard.jsp?num=<%= num %>'">수정</span>
                                    <span class="delete-btn" onclick="deletePost('<%= num %>')">삭제</span>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>
    </article>

    <div class="comments">
        <h2>댓글 (<span id="commentCount"><%= board.get("comment") %></span>)</h2>
        <div id="comment-section">
            <%
                try {
                    sql = "SELECT * FROM comment WHERE board_num = ? ORDER BY comment_date ASC";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, num);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String commentId = rs.getString("comment_id");
                        String commentWrite = rs.getString("comment_write");
            %>
                        <div class="comment">
                            <p class="user_info">
                                <img src="image/user_logo.png" alt="작성자 : ">&nbsp;&nbsp;<%= commentWrite %>
                                &nbsp;&nbsp;&nbsp;작성일: <%= rs.getString("comment_date") %>
                                <% if (commentWrite.equals(click_user)) { %>
                                    <span class="delete-btn" onclick="deleteComment('<%= commentId %>')">삭제</span>
                                <% } %>
                            </p>
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
        </div>
        <% if (click_user != null) { %>
            <form onsubmit="addComment(event)" class="comment-form">
                <input type="hidden" name="board_num" value="<%= num %>">
                <textarea name="content" required></textarea>
                <button type="submit">댓글 달기</button>
            </form>
        <% } %>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>
