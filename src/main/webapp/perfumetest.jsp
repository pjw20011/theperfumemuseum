<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfume Test</title>
    <link rel="stylesheet" href="css/perfumetest.css">
    <script src="js/perfumetest.js"></script>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <main>
        <div class="question-container">
            <form id="perfumeTestForm" action="result.jsp" method="post">
                <div class="question active" id="question1">
                    <p>어떤 여행지가 가장 마음에 드나요?</p>
                    <div class="option" onclick="selectOption(this, '%rose')">꽃들이 만발한 정원이 있는 곳</div>
                    <div class="option" onclick="selectOption(this, '%wood')">숲속의 오두막</div>
                    <div class="option" onclick="selectOption(this, '%lemon')">상쾌한 과일 향이 가득한 해변</div>
                    <div class="option" onclick="selectOption(this, '%musk')">이국적이고 신비로운 시장</div>
                </div>
                <div class="question" id="question2">
                    <p>가장 좋아하는 계절은?</p>
                    <div class="option" onclick="selectOption(this, '%rose')">봄</div>
                    <div class="option" onclick="selectOption(this, '%wood')">가을</div>
                    <div class="option" onclick="selectOption(this, '%lemon')">여름</div>
                    <div class="option" onclick="selectOption(this, '%musk')">겨울</div>
                </div>
                <div class="question" id="question3">
                    <p>집에서 가장 좋아하는 공간은?</p>
                    <div class="option" onclick="selectOption(this, '%rose')">정원</div>
                    <div class="option" onclick="selectOption(this, '%wood')">서재</div>
                    <div class="option" onclick="selectOption(this, '%lemon')">테라스</div>
                    <div class="option" onclick="selectOption(this, '%musk')">거실</div>
                </div>
                <div class="question" id="question4">
                    <p>힐링이 필요할 때 무엇을 하시나요?</p>
                    <div class="option" onclick="selectOption(this, '%rose')">꽃 가꾸기</div>
                    <div class="option" onclick="selectOption(this, '%wood')">하이킹</div>
                    <div class="option" onclick="selectOption(this, '%lemon')">해변에서 놀기</div>
                    <div class="option" onclick="selectOption(this, '%musk')">명상</div>
                </div>
                <div class="question" id="question5">
                    <p>어떤 활동을 가장 즐기시나요?</p>
                    <div class="option" onclick="selectOption(this, '%rose')">꽃꽂이</div>
                    <div class="option" onclick="selectOption(this, '%wood')">숲속 산책</div>
                    <div class="option" onclick="selectOption(this, '%lemon')">해변 산책</div>
                    <div class="option" onclick="selectOption(this, '%musk')">요가</div>
                </div>
                <input type="hidden" name="answer" id="answer">
                <button type="submit" id="submitBtn" class="hidden">Submit</button>
            </form>
        </div>
    </main>
</body>
</html>
