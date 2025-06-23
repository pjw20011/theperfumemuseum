document.addEventListener("DOMContentLoaded", function() {
    const usernameInput = document.getElementById('username');
    const usernameError = document.getElementById('username-error');
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirm-password');
    const passwordStrengthText = document.getElementById('password-strength2');
    const passwordErrorText = document.getElementById('password-error2');
    const passwordMatchText = document.getElementById('password-match2');

    // 현재 사용자의 이름을 가져오기 위해 세션에서 값을 읽어옴
    const currentUsername = document.querySelector('meta[name="username"]').content;

    if (usernameInput) {
        usernameInput.addEventListener('input', function() {
            checkNameAvailability(usernameInput.value, currentUsername);
        });
    }
    if (passwordInput) {
        passwordInput.addEventListener('input', checkPasswordStrength);
    }
    if (confirmPasswordInput) {
        confirmPasswordInput.addEventListener('input', checkPasswordMatch);
    }

    function checkNameAvailability(username, currentUsername) {
        if (username === "") {
            usernameError.textContent = "";
            return;
        }

        if (username === currentUsername) {
            usernameError.style.color = 'green';
            usernameError.textContent = '사용 가능한 이름입니다.';
            return;
        }

        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'checkUsername.jsp?username=' + encodeURIComponent(username), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const response = xhr.responseText.trim();
                if (response === 'available') {
                    usernameError.style.color = 'green';
                    usernameError.textContent = '사용 가능한 이름입니다.';
                } else if (response === 'unavailable') {
                    usernameError.style.color = 'red';
                    usernameError.textContent = '이미 사용 중인 이름입니다.';
                } else {
                    usernameError.style.color = 'red';
                    usernameError.textContent = '오류가 발생했습니다.';
                }
            }
        };
        xhr.send();
    }

    function checkPasswordStrength() {
        const password = passwordInput.value;
        let strength = '';
        let color = '';

        if (password.length < 6) {
            strength = '위험';
            color = 'red';
        } else if (password.length < 10 || !/[A-Z]/.test(password) || !/[0-9]/.test(password) || !/[^A-Za-z0-9]/.test(password)) {
            strength = '보통';
            color = 'orange';
        } else {
            strength = '안전';
            color = 'green';
        }

        passwordStrengthText.textContent = `비밀번호 위험도: ${strength}`;
        passwordStrengthText.style.color = color;
    }

    function checkPasswordMatch() {
        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        if (password === confirmPassword) {
            passwordErrorText.style.display = 'none';
            passwordMatchText.style.display = 'inline';
        } else {
            passwordErrorText.style.display = 'inline';
            passwordMatchText.style.display = 'none';
        }
    }
});
