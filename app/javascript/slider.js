// 現在のスライダー値を保持するオブジェクト
const sliderState = {
  min: 0,
  max: 50000,
};

const slider = () => {
  const priceSlider = document.getElementById('price-range-slider');

  if (!priceSlider) return; // スライダーが存在しない場合は終了

  // 既存のスライダーインスタンスを破棄
  if (priceSlider.noUiSlider) {
    priceSlider.noUiSlider.destroy();
  }

  // スライダーを再初期化
  noUiSlider.create(priceSlider, {
    start: [sliderState.min, sliderState.max], // 保存した値を使用
    connect: true,     // 範囲を色付け
    range: {
      min: 0,
      max: 50000,
    },
    step: 500,         // ステップ値
  });

  // スライダーの値が変更されるたびに表示を更新
  const minPriceValue = document.getElementById('min-price-value');
  const maxPriceValue = document.getElementById('max-price-value');

  priceSlider.noUiSlider.on('update', (values) => {
    minPriceValue.textContent = Math.round(values[0]);
    maxPriceValue.textContent = Math.round(values[1]);
  });

  // スライダーの値が変更されたら値を保持し、イベントをディスパッチ
  priceSlider.noUiSlider.on('change', (values) => {
    const minPrice = Math.round(values[0]);
    const maxPrice = Math.round(values[1]);

    // 値を保持
    sliderState.min = minPrice;
    sliderState.max = maxPrice;

    // total.jsに値を渡す
    document.dispatchEvent(new CustomEvent('priceUpdated', { detail: { minPrice, maxPrice } }));
  });
};

document.addEventListener("turbo:load", slider);
document.addEventListener("turbo:render", slider);
