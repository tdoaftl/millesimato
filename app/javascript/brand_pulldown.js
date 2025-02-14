const brand_pulldown = () => {
  const searchBox = document.getElementById('brand-search-box');
  const searchResults = document.getElementById('brand-search-results');

  // サーチボックス入力時の処理
  searchBox.addEventListener('input', async () => {
    const query = searchBox.value.toLowerCase(); // 入力を小文字に変換

    if (query.length === 0) {
      searchResults.style.display = 'none';
      searchResults.innerHTML = '';
      return;
    }

      const response = await fetch(`/clothings/brand_check?query=${encodeURIComponent(query)}`);
      const results = await response.json();

      searchResults.innerHTML = '';
      if (results.length > 0) {
        results.forEach((result) => {
          const li = document.createElement('li');
          li.textContent = result.name;
          li.style.cursor = 'pointer';

          // プルダウン選択時の処理
          li.addEventListener('click', () => {
            searchBox.value = ''; // サーチボックスをクリア
            searchResults.style.display = 'none';
            searchResults.innerHTML = '';

            // 該当チェックボックスをオンにする
            const checkbox = document.querySelector(`input[value="${result.id}"]`); // ブランドIDで一致するチェックボックス
            if (checkbox) {
              checkbox.checked = true;

             // brandのfilter-checkboxのうち、チェックがついているものをカウント
                 const checkedBrandCheckboxes = document.querySelectorAll('.filter-checkbox[data-filter="brand"]:checked');
                 const checkedCount = checkedBrandCheckboxes.length;


            // カウント表示
                const brandCountSpan = document.getElementById('brand-count');
                if (brandCountSpan) {
                 brandCountSpan.textContent = checkedCount > 0 ? checkedCount : "";
                 brandCountSpan.style.visibility = checkedCount > 0 ? "visible" : "hidden";
                }

              
              // total.jsに値を渡す
              document.dispatchEvent(
                new CustomEvent('checkboxUpdated', {
                  detail: { filterType: 'brand', value: result.id, isChecked: true },
                })
              );
            }
          });

          searchResults.appendChild(li);
        });
        searchResults.style.display = 'block';
      } else {
        searchResults.style.display = 'none';
      }

  });
};

window.addEventListener("turbo:load", brand_pulldown);
