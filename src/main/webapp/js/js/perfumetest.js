let currentQuestion = 1;
let answers = [];

function selectOption(element, value) {
    answers.push(value);
    document.getElementById('answer').value = answers.join(',');
    const nextQuestion = document.getElementById('question' + (currentQuestion + 1));
    if (nextQuestion) {
        document.getElementById('question' + currentQuestion).classList.remove('active');
        nextQuestion.classList.add('active');
        currentQuestion++;
    } else {
        document.getElementById('submitBtn').classList.remove('hidden');
    }
}
