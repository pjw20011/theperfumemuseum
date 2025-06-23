<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Perfume museum</title>
    <link rel="stylesheet" href="css/index.css">
    <script src="js/slider.js" defer></script>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    
    <main class="background-image">
        <section class="hero">
            <div class="slider">
                <div class="slide active" style="background-image: url('image/perfume1.jpg');"></div>
                <div class="slide" style="background-image: url('image/perfume2.jpg');"></div>
                <div class="slide" style="background-image: url('image/perfume3.jpg');"></div>
                <div class="slide" style="background-image: url('image/perfume4.jpg');"></div>
            </div>
        </section>
    </main>
</body>
<%@ include file="footer.jsp" %>
</html>
