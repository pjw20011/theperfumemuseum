<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="username" content="<c:out value='${username}' />">
    <title>My Page</title>
    <link rel="stylesheet" href="css/mypage.css">
    <script src="js/mypage.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function navigateToBoard(boardNum) {
            window.location.href = 'board_view.jsp?num=' + boardNum;
        }

        function sortContent(order, section) {
            const urlParams = new URLSearchParams(window.location.search);
            urlParams.set('section', section);
            urlParams.set('order', order);
            window.location.search = urlParams.toString();
        }

        function triggerFileInput() {
            document.getElementById('profileImageInput').click();
        }

        function previewProfileImage(event) {
            const reader = new FileReader();
            reader.onload = function(){
                const preview = document.getElementById('profileImagePreview');
                preview.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }
        
        function removeProfileImage() {
            const preview = document.getElementById('profileImagePreview');
            const fileInput = document.getElementById('profileImageInput');
            preview.src = 'image/user_logo.png';
            fileInput.value = '';
        }

        function sample4_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var roadAddr = data.roadAddress;
                    var extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    document.getElementById('sample4_postcode').value = data.zonecode;
                    document.getElementById("sample4_roadAddress").value = roadAddr;
                    document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                    if (roadAddr !== '') {
                        document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                    } else {
                        document.getElementById("sample4_extraAddress").value = '';
                    }

                    var guideTextBox = document.getElementById("guide");
                    if (data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else if (data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else {
                        guideTextBox.innerHTML = '';
                        guideTextBox.style.display = 'none';
                    }
                }
            }).open();
        }
    </script>

</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <div class="container">
        <aside class="sidebar">
            <ul>
                <li><a href="mypage.jsp?section=posts">내가 작성한 글</a></li>
                <li><a href="mypage.jsp?section=comments">내가 댓글 단 글</a></li>
                <li><a href="mypage.jsp?section=likes">내가 좋아요 누른 글</a></li>
                <li><a href="mypage.jsp?section=editProfile">회원정보 수정</a></li>
                <li><a href="mypage.jsp?section=changePassword">비밀번호 변경</a></li>
                <li><a href="mypage.jsp?section=deleteAccount">회원탈퇴</a></li>
            </ul>
        </aside>
        <main class="content">
            <h1>My Page</h1>
            <% 
                String section = request.getParameter("section");
                if (!"editProfile".equals(section)) {
                    int postCount = 0;
                    int commentCount = 0;
                    int likeCount = 0;

                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        // 작성한 게시글 수
                        String postCountSql = "SELECT COUNT(*) AS post_count FROM board WHERE writer = ?";
                        pstmt = conn.prepareStatement(postCountSql);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            postCount = rs.getInt("post_count");
                        }
                        rs.close();
                        pstmt.close();

                        // 작성한 댓글 수
                        String commentCountSql = "SELECT COUNT(*) AS comment_count FROM comment WHERE comment_write = ?";
                        pstmt = conn.prepareStatement(commentCountSql);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            commentCount = rs.getInt("comment_count");
                        }
                        rs.close();
                        pstmt.close();

                        // 좋아요 누른 수
                        String likeCountSql = "SELECT COUNT(*) AS like_count FROM boardgreat WHERE click_user = ?";
                        pstmt = conn.prepareStatement(likeCountSql);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            likeCount = rs.getInt("like_count");
                        }
                        rs.close();
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    }
            %>
            <div class="user-info">
                <p><strong><%= username %></strong>님 안녕하세요.</p>
                <h3>활동 내역</h3>
                <p class="activity-details"><span class="activity-details-title">게시글 작성 수 </span><span>: <%= postCount %>개</span></p>
                <p class="activity-details"><span class="activity-details-title">댓글 작성 수 </span><span>: <%= commentCount %>개</span></p>
                <p class="activity-details"><span class="activity-details-title">좋아요 누른 수 </span><span>: <%= likeCount %>개</span></p>
            </div>
            <% } %>
            <div class="section-content">
                <% 
                    PreparedStatement pstmtSection = null;
                    ResultSet rsSection = null;
                    String order = request.getParameter("order");

                    if ("posts".equals(section)) {
                        // 내가 작성한 글
                %>		<div class="add">
	                        <span><h2>내가 작성한 글</h2></span>
	                        <div class="sort-select">
	                       	 	
	                            <label for="sortOrderPosts">정렬 : </label>
	                            <select id="sortOrderPosts" onchange="sortContent(this.value, 'posts')">
	                                <option value="asc" <%= "asc".equals(order) ? "selected" : "" %>>최신순</option>
	                                <option value="desc" <%= "desc".equals(order) ? "selected" : "" %>>오래된순</option>
	                            </select>
	                        </div>
                        </div>
                        <%
                            try {
                                if (conn == null) {
                                    throw new Exception("Database connection is null");
                                }
                                String sql = "SELECT board_num, subject, writer, date, great, comment FROM board WHERE writer = ? ORDER BY date ";
                                sql += "asc".equals(order) ? "ASC" : "DESC";
                                pstmtSection = conn.prepareStatement(sql);
                                pstmtSection.setString(1, username);
                                rsSection = pstmtSection.executeQuery();
                        %>
                                <div class='post-list'>
                                    <%
                                        while (rsSection.next()) {
                                            int boardNum = rsSection.getInt("board_num");
                                            String subject = rsSection.getString("subject");
                                            String writer = rsSection.getString("writer");
                                            String date = rsSection.getString("date");
                                            int great = rsSection.getInt("great");
                                            int comment = rsSection.getInt("comment");
                                    %>
                                            <div class='post-item' onclick="navigateToBoard(<%= boardNum %>)">
                                                <div>
                                                    <h3><%= subject %></h3>
                                                    <p><%= writer %>&nbsp;&nbsp;작성일: <%= date %></p>
                                                </div>
                                                <div class="post-actions">
                                                    <span><img src='image/heart.png' alt='좋아요'><%= great %></span>
                                                    <span><img src='image/comment.png' alt='댓글'><%= comment %></span>
                                                </div>
                                            </div>
                                    <%
                                        }
                                    %>
                                </div>
                        <%
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                out.println("<p>Error: " + e.getMessage() + "</p>");
                                e.printStackTrace();
                            } finally {
                                if (rsSection != null) try { rsSection.close(); } catch (SQLException ignore) {}
                                if (pstmtSection != null) try { pstmtSection.close(); } catch (SQLException ignore) {}
                            }
                        %>
                <% 
                    } else if ("comments".equals(section)) {
                        // 내가 댓글 단 글
                %>		
                		<div class="add">
	                        <span><h2>내가 댓글 단 글</h2></span>
	                        <div class="sort-select">
	                            <label for="sortOrderComments">정렬:</label>
	                            <select id="sortOrderComments" onchange="sortContent(this.value, 'comments')">
	                                <option value="asc" <%= "asc".equals(order) ? "selected" : "" %>>최신순</option>
	                                <option value="desc" <%= "desc".equals(order) ? "selected" : "" %>>오래된순</option>
	                            </select>
	                        </div>
                        </div>
                        <%
                            try {
                                if (conn == null) {
                                    throw new Exception("Database connection is null");
                                }
                                String sql = "SELECT c.comment_id, c.comment_content, c.comment_date, b.board_num, b.subject, b.writer FROM comment c JOIN board b ON c.board_num = b.board_num WHERE c.comment_write = ? ORDER BY c.comment_date ";
                                sql += "asc".equals(order) ? "ASC" : "DESC";
                                pstmtSection = conn.prepareStatement(sql);
                                pstmtSection.setString(1, username);
                                rsSection = pstmtSection.executeQuery();
                        %>
                                <div class='comment-list'>
                                    <%
                                        while (rsSection.next()) {
                                            int boardNum = rsSection.getInt("board_num");
                                            int commentId = rsSection.getInt("comment_id");
                                            String commentContent = rsSection.getString("comment_content");
                                            String commentDate = rsSection.getString("comment_date");
                                            String writer = rsSection.getString("writer");
                                            String subject = rsSection.getString("subject");
                                    %>
                                            <div class='comment-item' onclick="navigateToBoard(<%= boardNum %>)">
                                                <div>
                                                    <h3><%= subject %></h3>
                                                    <span>게시글 작성자 : <%= writer %></span>
                                                    <br>
                                                    <p>내용 : <%= commentContent %></p>
                                                    <p>작성일: <%= commentDate %></p>
                                                </div>
                                            </div>
                                    <%
                                        }
                                    %>
                                </div>
                        <%
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                out.println("<p>Error: " + e.getMessage() + "</p>");
                                e.printStackTrace();
                            } finally {
                                if (rsSection != null) try { rsSection.close(); } catch (SQLException ignore) {}
                                if (pstmtSection != null) try { pstmtSection.close(); } catch (SQLException ignore) {}
                            }
                        %>
                <% 
                    } else if ("likes".equals(section)) {
                        // 내가 좋아요 누른 글
                %>
                		<div class="add">
	                        <span><h2>내가 좋아요 누른 글</h2></span>
	                        <div class="sort-select">
	                            <label for="sortOrderLikes">정렬:</label>
	                            <select id="sortOrderLikes" onchange="sortContent(this.value, 'likes')">
	                                <option value="asc" <%= "asc".equals(order) ? "selected" : "" %>>최신순</option>
	                                <option value="desc" <%= "desc".equals(order) ? "selected" : "" %>>오래된순</option>
	                            </select>
	                        </div>
                        </div>
                        <%
                            try {
                                if (conn == null) {
                                    throw new Exception("Database connection is null");
                                }
                                String sql = "SELECT b.board_num, b.subject, b.writer, b.date FROM boardgreat g JOIN board b ON g.board_id = b.board_num WHERE g.click_user = ? ORDER BY b.date ";
                                sql += "asc".equals(order) ? "ASC" : "DESC";
                                pstmtSection = conn.prepareStatement(sql);
                                pstmtSection.setString(1, username);
                                rsSection = pstmtSection.executeQuery();
                        %>
                                <div class='like-list'>
                                    <%
                                        while (rsSection.next()) {
                                            int boardNum = rsSection.getInt("board_num");
                                            String subject = rsSection.getString("subject");
                                            String writer = rsSection.getString("writer");
                                            String date = rsSection.getString("date");
                                    %>
                                            <div class='like-item' onclick="navigateToBoard(<%= boardNum %>)">
                                                <div>
                                                    <h3><%= subject %></h3>
                                                    <p><%= writer %>&nbsp;&nbsp;작성일: <%= date %></p>
                                                </div>
                                            </div>
                                    <%
                                        }
                                    %>
                                </div>
                        <%
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                out.println("<p>Error: " + e.getMessage() + "</p>");
                                e.printStackTrace();
                            } finally {
                                if (rsSection != null) try { rsSection.close(); } catch (SQLException ignore) {}
                                if (pstmtSection != null) try { pstmtSection.close(); } catch (SQLException ignore) {}
                            }
                        %>
                <% 
                    } else if ("editProfile".equals(section)) {
                        // 회원정보 수정 폼
                %>
                        <h2>회원정보 수정</h2>
                        <%
                            try {
                                if (conn == null) {
                                    throw new Exception("Database connection is null");
                                }
                                String sql = "SELECT username, email, zipcode, roadname_address, main_address, detail_address, reference_address, profile_image FROM user WHERE userid = ?";
                                pstmtSection = conn.prepareStatement(sql);
                                pstmtSection.setString(1, username);
                                rsSection = pstmtSection.executeQuery();
                                if (rsSection.next()) {
                                    String userFullname = rsSection.getString("username");
                                    String email = rsSection.getString("email");
                                    String zipcode = rsSection.getString("zipcode");
                                    String roadnameAddress = rsSection.getString("roadname_address");
                                    String mainAddress = rsSection.getString("main_address");
                                    String detailAddress = rsSection.getString("detail_address");
                                    String referenceAddress = rsSection.getString("reference_address");
                                    String profileImage = rsSection.getString("profile_image");
                                    String profileImageUrl = (profileImage != null && !profileImage.isEmpty()) ? "uploads/" + profileImage : "image/user_logo.png";
                        %>
                                    <form class="user-info-form" action="updateProfile.jsp" method="post" enctype="multipart/form-data">

                                        <label for="username">이름</label>
										<input type='text' name='username' id='username' value='<%= userFullname %>'>
										<span class="username-error" id="username-error" style="display:block;"></span>

                                        
                                        <label for="email">이메일</label>
                                        <input type='email' name='email' value='<%= email %>'>
                                        <label for="zipcode">우편번호</label>
                                        <div class="address-section">
                                            <input type="text" id="sample4_postcode" name="zipcode" value="<%= zipcode %>" placeholder="우편번호" required readonly>
                                            <button type="button" onclick="sample4_execDaumPostcode()">주소 찾기</button>
                                        </div>
                                        <label for="roadname_address">도로명 주소</label>
                                        <input type="text" id="sample4_roadAddress" name="roadname_address" value="<%= roadnameAddress %>" placeholder="도로명주소" required readonly>
                                        <label for="main_address">지번 주소</label>
                                        <input type="text" id="sample4_jibunAddress" name="main_address" value="<%= mainAddress %>" placeholder="지번주소" required readonly>
                                        <label for="detail_address">상세 주소</label>
                                        <input type='text' name='detail_address' value='<%= detailAddress %>'>
                                        <label for="reference_address">참고 사항</label>
                                        <input type='text' id="sample4_extraAddress" name='reference_address' value='<%= referenceAddress %>' placeholder="참고항목" required readonly>
                                        <span id="guide" style="color:#999;display:none"></span>
                                        <button type='submit'>수정</button>
                                    </form>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                out.println("<p>Error: " + e.getMessage() + "</p>");
                                e.printStackTrace();
                            } finally {
                                if (rsSection != null) try { rsSection.close(); } catch (SQLException ignore) {}
                                if (pstmtSection != null) try { pstmtSection.close(); } catch (SQLException ignore) {}
                            }
                        %>
                <% 
                    } else if ("changePassword".equals(section)) {
                        // 비밀번호 변경 폼
                %>
                        <h2>비밀번호 변경</h2>
                        <form class="user-info-form" action="changePassword.jsp" method="post">
						    <label for="currentPassword"></label>
						    <input type='password' name='currentPassword' placeholder="현재 비밀번호">
						    <div class="input-group">
						        <label for="password">
						            <input type="password" id="password" name="password" placeholder="비밀번호" required>
						            <span id="password-strength2"></span>
						        </label>
						    </div>
						    <div class="input-group">
						        <label for="confirm-password">
						            <input type="password" id="confirm-password" name="confirm-password" placeholder="비밀번호 재확인" required>
						            <span id="password-error2" class="password-check" style="color: red; display: none;">비밀번호가 일치하지 않습니다.</span>
						            <span id="password-match2" class="password-check" style="color: green; display: none;">비밀번호가 일치합니다.</span>
						        </label>
						    </div>
						    <button type='submit'>변경</button>
						</form>

                <% 
                    } else if ("deleteAccount".equals(section)) {
                        // 회원탈퇴 폼
                %>
                        <h2>회원탈퇴</h2>
                        <form class="user-info-form" action="deleteAccount.jsp" method="post">
                            <label for="password">비밀번호</label>
                            <input type='password' name='password'>
                            <button type='submit'>탈퇴</button>
                        </form>
                <% 
                    } else {
                %>
                        <p>왼쪽 메뉴에서 항목을 선택하세요.</p>
                <% 
                    }
                %>
            </div>	
        </main>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>
