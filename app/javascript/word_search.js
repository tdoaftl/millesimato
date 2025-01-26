const word_search = () => {
  const searchQueryInput = document.getElementById('free-word-search');
  const enableSearchCheckbox = document.getElementById('free-word-checkbox');



        // 入力時にチェックボックスをオフにする
  searchQueryInput.addEventListener('input', () => {
    enableSearchCheckbox.checked = false; // チェックボックスをオフ
      });
    
      // チェックボックスをオン
      enableSearchCheckbox.addEventListener('change', () => {
        const isSearchEnabled = enableSearchCheckbox.checked;
        const searchWord = isSearchEnabled ? searchQueryInput.value.trim() : null;
    
        // total.jsに値を渡す
        document.dispatchEvent(new CustomEvent('wordUpdated', { detail: { searchWord } }));
      });
    };

    window.addEventListener("turbo:load", word_search);
