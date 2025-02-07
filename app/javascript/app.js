const app = () => {
  document.removeEventListener("turbo:before-cache", resetCollapses);
  document.addEventListener("turbo:before-cache", resetCollapses);

  document.removeEventListener("turbo:load", initializeCollapses);
  document.addEventListener("turbo:load", initializeCollapses);
};

// collapse の状態をリセット
const resetCollapses = () => {
  document.querySelectorAll(".collapse.show").forEach((collapse) => {
    let bsCollapse = bootstrap.Collapse.getInstance(collapse);
    if (bsCollapse) {
      bsCollapse.hide(); // Bootstrap メソッドで閉じる
    }
    collapse.classList.remove("show"); // show クラス削除
    collapse.setAttribute("aria-expanded", "false"); // aria-expanded リセット
    collapse.style.height = null; // 高さリセット
  });
};

// Bootstrap の Collapse を再初期化
const initializeCollapses = () => {
  document.querySelectorAll(".collapse").forEach((collapse) => {
    new bootstrap.Collapse(collapse, { toggle: false });
  });
};

// Turbo のイベントを正しく設定
document.addEventListener("turbo:load", app);
