  document.addEventListener("DOMContentLoaded", function () {
    var collapseButtons = document.querySelectorAll("[data-bs-toggle='collapse']");

    collapseButtons.forEach(function (button) {
      var icon = button.querySelector(".toggle-icon"); // ボタン内のアイコンを取得
      var collapseTargetId = button.getAttribute("data-bs-target");
      var collapseElement = document.querySelector(collapseTargetId);

      collapseElement.addEventListener("show.bs.collapse", function () {
        icon.classList.add("rotate-open"); // 開くときに回転
      });

      collapseElement.addEventListener("hide.bs.collapse", function () {
        icon.classList.remove("rotate-open"); // 閉じるときに元に戻す
      });
    });
  });