document.addEventListener("turbo:load", () => {
  if (!window.bootstrap) {
    console.error("Bootstrap is not loaded properly.");
    return;
  }
  
  // Bootstrap Collapse を再初期化
  document.querySelectorAll(".collapse").forEach((element) => {
    new window.bootstrap.Collapse(element, {
      toggle: false, // 初期状態では展開しない
    });
  });
});
