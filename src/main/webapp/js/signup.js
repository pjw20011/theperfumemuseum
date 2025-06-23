document.addEventListener("DOMContentLoaded", function() {
    const useridInput = document.getElementById('userid');
    const usernameError = document.getElementById('username-error');
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirm-password');
    const passwordStrengthText = document.getElementById('password-strength');
    const passwordErrorText = document.getElementById('password-error');
    const passwordMatchText = document.getElementById('password-match');

    useridInput.addEventListener('input', checkUsernameAvailability);
    passwordInput.addEventListener('input', checkPasswordStrength);
    confirmPasswordInput.addEventListener('input', checkPasswordMatch);

    function checkUsernameAvailability() {
        const userid = useridInput.value;
        if (userid === "") {
            usernameError.textContent = "";
            return;
        }

        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'checkUsername.jsp?userid=' + encodeURIComponent(userid), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const response = xhr.responseText.trim();
                if (response === 'available') {
                    usernameError.style.color = 'green';
                    usernameError.textContent = '사용 가능한 아이디입니다.';
                } else {
                    usernameError.style.color = 'red';
                    usernameError.textContent = '이미 사용 중인 아이디입니다.';
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
