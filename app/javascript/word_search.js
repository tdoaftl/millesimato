const word_search = () => {
  const textInput = document.getElementById('free-word-search');
  const enableCheckbox = document.getElementById('free-word-checkbox');



        // 入力時にチェックボックスをオフにする
    textInput.addEventListener('input', () => {
    enableCheckbox.checked = false; // チェックボックスをオフ
      });
    
      // チェックボックスをオン
      enableCheckbox.addEventListener('change', () => {

        const isSearchEnabled = enableCheckbox.checked;
        const searchWord = isSearchEnabled ? textInput.value.trim() : null;
    
        // total.jsに値を渡す
        document.dispatchEvent(new CustomEvent('wordUpdated', { detail: { searchWord } }));

});
    };

    window.addEventListener("turbo:load", word_search);
