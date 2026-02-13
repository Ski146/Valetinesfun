<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>💌 Will You Be My Valentine Gurl? Hehehe!</title>
  <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&family=Lora:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --pink: #f472b6;
      --deep: #be185d;
      --blush: #fce7f3;
      --cream: #fff8f0;
    }

    html, body {
      width: 100%; height: 100%;
      overflow: hidden;
    }

    body {
      min-height: 100vh;
      background: var(--cream);
      font-family: 'Lora', Georgia, serif;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* Floating hearts */
    .heart-bg { position: fixed; inset: 0; pointer-events: none; z-index: 0; }
    .floaty {
      position: absolute;
      opacity: 0;
      animation: floatUp linear infinite;
      user-select: none;
    }
    @keyframes floatUp {
      0%   { opacity: 0; transform: translateY(0) rotate(0deg) scale(0.8); }
      10%  { opacity: 0.6; }
      90%  { opacity: 0.4; }
      100% { opacity: 0; transform: translateY(-110vh) rotate(30deg) scale(1.2); }
    }

    /* Card — plain stacking context, no overflow:hidden */
    .card {
      position: relative;
      z-index: 10;
      background: white;
      border-radius: 2.5rem;
      padding: 3rem 2.8rem 2.8rem;
      max-width: 480px;
      width: 92vw;
      text-align: center;
      box-shadow:
        0 0 0 6px var(--blush),
        0 0 0 10px #f9a8d4,
        0 25px 70px rgba(244,114,182,0.28);
      animation: cardIn 0.9s cubic-bezier(.34,1.56,.64,1) both;
    }
    @keyframes cardIn {
      from { opacity: 0; transform: scale(0.7) translateY(40px); }
      to   { opacity: 1; transform: scale(1)   translateY(0);    }
    }

    .bear {
      font-size: 5.5rem;
      line-height: 1;
      display: block;
      margin-bottom: 0.5rem;
      animation: bounce 2s ease-in-out infinite;
    }
    @keyframes bounce {
      0%,100% { transform: translateY(0);    }
      50%      { transform: translateY(-10px); }
    }

    h1 {
      font-family: 'Dancing Script', cursive;
      font-size: 2.6rem;
      color: var(--deep);
      line-height: 1.2;
      margin-bottom: 0.7rem;
    }

    .subtitle {
      font-style: italic;
      color: #c084a0;
      font-size: 1.05rem;
      margin-bottom: 2rem;
    }

    .buttons { display: flex; justify-content: center; }

    .btn-yes {
      background: linear-gradient(135deg, var(--pink), var(--deep));
      color: white;
      border: none;
      padding: 0.85rem 2.5rem;
      font-size: 1.15rem;
      font-family: 'Lora', serif;
      font-weight: 600;
      border-radius: 999px;
      cursor: pointer;
      box-shadow: 0 6px 20px rgba(244,114,182,0.45);
      animation: yesGlow 3s ease-in-out infinite;
    }
    @keyframes yesGlow {
      0%,100% { transform: scale(1);    box-shadow: 0 6px 20px rgba(244,114,182,.45); }
      50%      { transform: scale(1.06); box-shadow: 0 10px 30px rgba(244,114,182,.65); }
    }
    .btn-yes:hover { transform: scale(1.12); }

    /*
      THE FIX:
      - position: fixed  → positioned relative to the VIEWPORT, never clipped by the card
      - No transition    → instant teleport, impossible to catch
      - Lives on <body>, not inside the card
    */
    #noBtn {
      position: fixed;
      z-index: 9999;
      background: #f3f4f6;
      color: #9ca3af;
      border: 2px solid #e5e7eb;
      padding: 0.85rem 2.2rem;
      font-size: 1.1rem;
      font-family: 'Lora', serif;
      font-weight: 600;
      border-radius: 999px;
      cursor: pointer;
      white-space: nowrap;
      user-select: none;
    }

    /* Yes screen */
    .yes-screen { display: none; flex-direction: column; align-items: center; gap: 1rem; }
    .yes-screen.show { display: flex; }
    .yes-screen .big-heart {
      font-size: 6rem;
      animation: heartPop 0.5s cubic-bezier(.34,1.56,.64,1) both;
    }
    @keyframes heartPop {
      from { transform: scale(0) rotate(-20deg); opacity: 0; }
      to   { transform: scale(1) rotate(0);       opacity: 1; }
    }
    .yes-screen h2 { font-family: 'Dancing Script', cursive; font-size: 2.4rem; color: var(--deep); }
    .yes-screen p  { color: #c084a0; font-style: italic; }

    /* Confetti */
    .confetti-piece {
      position: fixed;
      pointer-events: none;
      z-index: 9998;
      animation: confettiFall linear forwards;
      border-radius: 2px;
    }
    @keyframes confettiFall {
      0%   { transform: translateY(-20px) rotate(0deg);   opacity: 1; }
      100% { transform: translateY(110vh) rotate(720deg); opacity: 0; }
    }
  </style>
</head>
<body>

<!-- Floating hearts background -->
<div class="heart-bg" id="heartBg"></div>

<!-- Card (No button is NOT inside here) -->
<div class="card" id="mainCard">

  <div id="askView">
    <span class="bear">🐻</span>
    <h1>Will you be my Valentine? 💝</h1>
    <p class="subtitle">I've been working up the courage to ask you this for a while...</p>
    <div class="buttons">
      <button class="btn-yes" id="yesBtn">Yes! 💖</button>
    </div>
  </div>

  <div class="yes-screen" id="yesView">
    <span class="big-heart">💗</span>
    <h2>Yay!! You made me the happiest! 🥰</h2>
    <p>I promise to make this the best Valentine's Day ever 🌹</p>
    <span style="font-size:3rem; margin-top:0.5rem;">🎉💌🍫🌹</span>
  </div>

</div>

<!-- No button is a DIRECT child of body, with position:fixed — fully escapes the card -->
<button id="noBtn">No</button>

<script>
  // ── Floating hearts ──────────────────────────────────────────────
  const bg = document.getElementById('heartBg');
  const hearts = ['❤️','💕','💗','💓','💞','🌸','💝','💘','🌷'];
  for (let i = 0; i < 22; i++) {
    const el = document.createElement('span');
    el.className = 'floaty';
    el.textContent = hearts[Math.floor(Math.random() * hearts.length)];
    el.style.left = Math.random() * 100 + 'vw';
    el.style.fontSize = (1 + Math.random() * 1.8) + 'rem';
    el.style.animationDuration = (6 + Math.random() * 9) + 's';
    el.style.animationDelay   = (Math.random() * 10) + 's';
    bg.appendChild(el);
  }

  // ── No button: runs away anywhere on the full screen ─────────────
  const noBtn  = document.getElementById('noBtn');
  const yesBtn = document.getElementById('yesBtn');

  // Start it right next to the Yes button
  function initNoBtn() {
    const yRect = yesBtn.getBoundingClientRect();
    noBtn.style.left = (yRect.right + 16) + 'px';
    noBtn.style.top  = yRect.top + 'px';
  }
  requestAnimationFrame(() => requestAnimationFrame(initNoBtn));
  window.addEventListener('resize', initNoBtn);

  const noMessages = [
    'Nope! 🏃',
    'Not today! 💨',
    'Catch me! 😂',
    'Too slow! 👀',
    'Try again! 🙈',
    'Nice try! 😏',
    'No way! 💅',
    'Haha nope! 🤭',
    'Never! 🫣',
    'Keep trying! 😜',
    'Not a chance! 🙃',
    'Gotcha! 😈',
    'Wrong button! 💘',
  ];
  let msgIdx = 0;

  function moveNoBtn() {
    const btnW = noBtn.offsetWidth  || 120;
    const btnH = noBtn.offsetHeight || 46;
    const pad  = 12;
    const vw   = window.innerWidth;
    const vh   = window.innerHeight;

    // Jump to a random position anywhere on screen (viewport)
    const newX = pad + Math.random() * (vw - btnW - pad * 2);
    const newY = pad + Math.random() * (vh - btnH - pad * 2);

    noBtn.style.left = newX + 'px';
    noBtn.style.top  = newY + 'px';
    noBtn.textContent = noMessages[msgIdx % noMessages.length];
    msgIdx++;
  }

  noBtn.addEventListener('mouseover',  moveNoBtn);
  noBtn.addEventListener('touchstart', (e) => { e.preventDefault(); moveNoBtn(); }, { passive: false });
  noBtn.addEventListener('click', moveNoBtn);

  // ── Yes button ───────────────────────────────────────────────────
  yesBtn.addEventListener('click', () => {
    document.getElementById('askView').style.display = 'none';
    noBtn.style.display = 'none';
    document.getElementById('yesView').classList.add('show');
    spawnConfetti();
  });

  // ── Confetti ─────────────────────────────────────────────────────
  const colors = ['#f472b6','#fb7185','#fbbf24','#34d399','#60a5fa','#a78bfa','#f9a8d4'];
  function spawnConfetti() {
    for (let i = 0; i < 100; i++) {
      setTimeout(() => {
        const el = document.createElement('div');
        el.className = 'confetti-piece';
        el.style.left = Math.random() * 100 + 'vw';
        el.style.background = colors[Math.floor(Math.random() * colors.length)];
        el.style.width  = (6 + Math.random() * 10) + 'px';
        el.style.height = (6 + Math.random() * 10) + 'px';
        el.style.borderRadius = Math.random() > 0.5 ? '50%' : '2px';
        el.style.animationDuration = (2 + Math.random() * 3) + 's';
        document.body.appendChild(el);
        setTimeout(() => el.remove(), 5500);
      }, i * 35);
    }
  }
</script>
</body>
</html>
