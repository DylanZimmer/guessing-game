<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="../styles.css">
</head>

<body>
  <div class="grid"></div>
  <div id="message" style="display: none; text-align: center; margin-top: 20px; font-size: 20px;"></div>
</body>


<script>
  const urlParams = new URLSearchParams(window.location.search);
  const birthMonthJs = urlParams.get('birthMonth');

  const winner = Math.ceil(Math.random() * 9);
  console.log(winner);
  let tries = 0;
  const grid = document.querySelector('.grid');

  for (let i = 1; i <= 9; i++) {
    const square = document.createElement('div');
    square.classList.add('square');
    square.textContent = i;
    square.addEventListener('click', () => {
        if (tries < 2) {
            tries += 1;
            if (i == winner) {
                square.style.backgroundColor = '#00FF00';
                messageBox.textContent = 'Congratulations! You got it in ' + (tries == 1? '1 try!' : '2 tries!');
                messageBox.style.display = 'block';
                if (tries == 1) {
                  setTimeout(() => {window.location.href = 'resultsPage.cfm?birthMonth=' + birthMonthJs + '&won=' + 1}, 1250);
                } else {
                  setTimeout(() => {window.location.href = 'resultsPage.cfm?birthMonth=' + birthMonthJs + '&won=' + 2}, 1250);
                }
            } else {
                square.style.backgroundColor = '#FF0000';
                if (tries == 2) {
                    messageBox.textContent = 'Better luck next time!';
                    messageBox.style.display = 'block';
                    setTimeout(() => {window.location.href = 'resultsPage.cfm?birthMonth=' + birthMonthJs + '&won=' + 0}, 1250);
                }
            }
        }
    });
    grid.appendChild(square);
  }
  const messageBox = document.getElementById('message');
</script>

</html>
