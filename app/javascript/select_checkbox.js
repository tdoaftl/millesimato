const select_checkbox = () => {
  const checkboxes = document.querySelectorAll('.filter-checkbox');

  // フィルターカテゴリーごとにカウントを更新する関数
  function updateFilterCount(filterType) {
    const checkCount = document.querySelectorAll(`.filter-checkbox[data-filter="${filterType}"]:checked`);
    const countSpan = document.getElementById(`${filterType}-count`);
    // countSpan が null でない場合のみ処理
    if (countSpan) {
      if (checkCount.length > 0) {
        countSpan.textContent = checkCount.length;
        countSpan.style.visibility = "visible"; // 表示する
      } else {
        countSpan.textContent = "";
        countSpan.style.visibility = "hidden"; // 非表示
      }
    }
  }

  const filterTypes = ["brand", "category", "size", "era", "gender", "condition", "color","material", "made_in" ];
  filterTypes.forEach(filterType => {
    const checkboxes = document.querySelectorAll(`.filter-checkbox[data-filter="${filterType}"]`);
    
    checkboxes.forEach(checkbox => {
      checkbox.addEventListener("change", function() {
        updateFilterCount(filterType);
      });
    });

    // 初期カウントを設定（ページ読み込み時）
    updateFilterCount(filterType);
  });





  checkboxes.forEach((checkbox) => {
    checkbox.addEventListener('change', () => {
      const filterType = checkbox.dataset.filter;
      const value = parseInt(checkbox.value, 10); // 値を数値に変換
      const isChecked = checkbox.checked;

      // total.jsに値を渡す
      document.dispatchEvent(new CustomEvent('checkboxUpdated', { 
        detail: { filterType, value, isChecked } 
      }));
    });
  });
};

window.addEventListener("turbo:load", select_checkbox);