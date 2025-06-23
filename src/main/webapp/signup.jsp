<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <link rel="stylesheet" href="css/signup.css">
    <script src="js/signup.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
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
	<div class="background-image"></div>
    <div class="signup-container">
        <h1>회원가입</h1>
        <br><br>
        <form action="signupProcess.jsp" name="signup" method="post" onsubmit="return checkForm()">
            <div class="input-group">
                <label for="userid">
                    <input type="text" id="userid" name="userid" placeholder="아이디" required>
                    <span id="username-error" style="display:block;"></span>
                </label>
            </div>
            <div class="input-group">
                <label for="password">
                    <input type="password" id="password" name="password" placeholder="비밀번호" required>
                    <span id="password-strength"></span>
                </label>
            </div>
            <div class="input-group">
                <label for="confirm-password">
                    <input type="password" id="confirm-password" name="confirm-password" placeholder="비밀번호 재확인" required>
                    <span id="password-error" class="password-check" style="color: red; display: none;">비밀번호가 일치하지 않습니다.</span>
                    <span id="password-match" class="password-check" style="color: green; display: none;">비밀번호가 일치합니다.</span>
                </label>
            </div>
            <div class="input-group">
                <label for="username">
                    <input type="text" id="username" name="username" placeholder="이름" required>
                </label>
            </div>
            <div class="input-group">
                <label for="email">
                    <input type="email" id="email" name="email" placeholder="이메일" required>
                </label>
            </div>
            <div class="input-group">
                <label id="address_find" for="postcode">
                    <input type="text" id="sample4_postcode" name="postcode" placeholder="우편번호" readonly>
                    <button type="button" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
                </label>
            </div>
            <div class="input-group">
                <label for="roadAddress">
                    <input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명 주소" readonly>
                </label>
            </div>
            <div class="input-group">
                <label for="jibunAddress">
                    <input type="text" id="sample4_jibunAddress" name="jibunAddress" placeholder="지번 주소" readonly>
                </label>
            </div>
            <div class="input-group">
                <label for="detailAddress">
                    <input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세 주소">
                </label>
            </div>
            <div class="input-group">
                <label for="extraAddress">
                    <input type="text" id="sample4_extraAddress" name="extraAddress" placeholder="참고 항목" readonly>
                </label>
            </div>
            <div id="guide" style="color:#999;display:none"></div>
            
            <button type="submit">계정 만들기</button>
        </form>
        <p class="login-text">이미 계정이 있으신가요?&nbsp;&nbsp;<a href="login.jsp">로그인하러가기!</a></p>
    </div>
</body>
</html>
