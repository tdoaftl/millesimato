document.addEventListener('DOMContentLoaded', () => {
  const filters = {
    searchWord: '', // 初期状態では空文字
    priceRange: { min: 0, max: 50000 }, // 価格範囲のデフォルト
    checkboxFilters: {} // 初期状態では空のオブジェクト
  };

  // スライダー初期化関数
  const initializeSlider = () => {
    const priceSlider = document.getElementById('price-range-slider');
    if (!priceSlider) return; // スライダー要素が存在しない場合は終了

    // 既存のスライダーインスタンスを破棄してから再初期化
    if (priceSlider.noUiSlider) {
      priceSlider.noUiSlider.destroy();
    }

    // 初期の価格範囲がfiltersに設定されていることを確認
    const minPrice = filters.priceRange.min || 0;
    const maxPrice = filters.priceRange.max || 50000;

    // スライダーを新たに初期化
    noUiSlider.create(priceSlider, {
      start: [minPrice, maxPrice],  // 初期価格範囲をfiltersの値に設定
      connect: true,
      range: { min: 0, max: 50000 },
      step: 500,
      format: {
        to: (value) => Math.round(value),
        from: (value) => value,
      },
    });

    // スライダーの値が更新される度に値を表示
    priceSlider.noUiSlider.on('update', (values) => {
      const minPrice = Math.round(values[0]);
      const maxPrice = Math.round(values[1]);

      // 数値表示を更新
      const minPriceDisplay = document.getElementById('min-price-value');
      const maxPriceDisplay = document.getElementById('max-price-value');

      if (minPriceDisplay && maxPriceDisplay) {
        minPriceDisplay.textContent = minPrice;
        maxPriceDisplay.textContent = maxPrice;
      }
    });

    // スライダーの値が変更されたらイベントをディスパッチ
    priceSlider.noUiSlider.on('change', (values) => {
      const minPrice = Math.round(values[0]);
      const maxPrice = Math.round(values[1]);

      document.dispatchEvent(new CustomEvent('priceUpdated', { detail: { minPrice, maxPrice } }));
    });
  };

  // Turboイベントをリッスンしてスライダーを再初期化
  document.addEventListener("turbo:load", () => {
    initializeSlider(); // ページ遷移時に再初期化
  });

  // 初期化
  initializeSlider();
});



 // 値表示の更新
 const minPriceValue = document.getElementById('min-price-value');
 const maxPriceValue = document.getElementById('max-price-value');

 priceSlider.noUiSlider.on('update', (values) => {
   minPriceValue.textContent = Math.round(values[0]);
   maxPriceValue.textContent = Math.round(values[1]);
 });

     // スライダーの値が変更されたらイベントをディスパッチ
     priceSlider.noUiSlider.on('change', (values) => {
       const minPrice = Math.round(values[0]);
       const maxPrice = Math.round(values[1]);
       
       // total.jsに値を渡す
       document.dispatchEvent(new CustomEvent('priceUpdated', { detail: { minPrice, maxPrice } }));
     });