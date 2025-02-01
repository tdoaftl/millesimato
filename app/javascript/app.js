document.addEventListener("turbo:load", () => {
  if (!window.bootstrap) {
    console.error("Bootstrap is not loaded properly.");
    return;
  }
  
  // ページロード時とページ遷移時にすべてのCollapseを閉じる
  const collapses = document.querySelectorAll('.collapse');
  collapses.forEach(collapse => {
    collapse.classList.remove('show');
  });
});


