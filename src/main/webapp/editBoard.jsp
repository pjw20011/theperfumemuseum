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

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, num);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            board.put("num", rs.getString("board_num"));
            board.put("subject", rs.getString("subject"));
            board.put("content", rs.getString("content"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }

    String referer = request.getHeader("Referer");
    if (referer == null || referer.contains("editPost.jsp")) {
        referer = "board.jsp";
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 수정</title>
    <link rel="stylesheet" href="css/signup.css">
    <link rel="stylesheet" href="css/board_write.css">
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <div class="create-container">
        <a id="board_list" href="<%= referer %>">⬅</a>
        <h1>글 수정</h1>
        <form method="post" action="updateBoard.jsp">
            <input type="hidden" name="num" value="<%= board.get("num") %>">
            <div class="input-group">
                <label for="subject">제목</label>
                <input type="text" id="subject" name="subject" value="<%= board.get("subject") %>" required>
            </div>
            <div class="input-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" required><%= board.get("content") %></textarea>
            </div>
            <button type="submit">수정하기</button>
        </form>
    </div>
    <script>
        CKEDITOR.replace('content');

        function previewImages(event) {
            const files = event.target.files;
            const imagePreviews = document.getElementById('image-previews');
            const maxFiles = 5;

            if (files.length > maxFiles) {
                alert("최대 " + maxFiles + "개의 이미지만 업로드할 수 있습니다.");
                event.target.value = ''; // 파일 입력 초기화
                imagePreviews.innerHTML = ''; // 미리보기 초기화
                return;
            }

            imagePreviews.innerHTML = ''; // 기존의 미리보기를 초기화

            Array.from(files).forEach((file, index) => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const div = document.createElement('div');
                    div.classList.add('image-preview');

                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.alt = `Image Preview ${index + 1}`;

                    const button = document.createElement('button');
                    button.classList.add('remove-image');
                    button.innerText = 'x';
                    button.onclick = () => removeImage(index);

                    div.appendChild(img);
                    div.appendChild(button);
                    imagePreviews.appendChild(div);
                }
                reader.readAsDataURL(file);
            });
        }

        function removeImage(index) {
            const input = document.getElementById('images');
            const dataTransfer = new DataTransfer();

            const files = Array.from(input.files);
            files.splice(index, 1);

            files.forEach(file => dataTransfer.items.add(file));
            input.files = dataTransfer.files;

            previewImages({ target: input });
        }
    </script>
</body>
<%@ include file="footer.jsp" %>
</html>
