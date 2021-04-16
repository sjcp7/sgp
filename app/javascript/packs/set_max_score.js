maxScore = document.querySelector('#test_max_score')
studentScores = document.querySelectorAll('.student_score')

if (maxScore) {
  maxScore.addEventListener('change', (el) => {
    studentScores.forEach(scoreEl => {
      scoreEl.max = el.target.value
    })
  })
} else {
  studentScores.forEach(scoreEl => {
    scoreEl.max = 20
  })
}
