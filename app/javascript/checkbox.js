const checkbox = () => {
  const checkboxes = document.querySelectorAll('.filter-checkbox');

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

window.addEventListener("turbo:load", checkbox);