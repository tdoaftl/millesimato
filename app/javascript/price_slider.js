// スライダーの初期化
var slider = document.getElementById('price-range-slider');

// スライダーの設定
noUiSlider.create(slider, {
  start: [3000, 23000],  // 初期価格範囲
  connect: true,
  range: {
    'min': 0,
    'max': 50000
  },
  step: 500,  // スライダーの幅を500に設定
  format: {
    to: function (value) {
      return Math.round(value);
    },
    from: function (value) {
      return value;
    }
  }
});

// スライダーの値が更新される度に、値を表示
slider.noUiSlider.on('update', function(values, handle) {
  var min_price = values[0];
  var max_price = values[1];

  // 数値表示を更新
  document.getElementById('min-price-value').textContent = Math.round(min_price);
  document.getElementById('max-price-value').textContent = Math.round(max_price);
});

// マウスを離した時に商品を取得して表示する関数
slider.noUiSlider.on('change', function(values, handle) {
  var min_price = values[0];
  var max_price = values[1];

  // min_priceとmax_priceがnullでないか確認
  if (min_price !== null && max_price !== null) {
    fetchProducts(min_price, max_price); // サーバーに商品をリクエスト
  }
});

// 商品を取得して表示する関数
function fetchProducts(min_price, max_price) {
  fetch(`/clothings/search?min_price=${min_price}&max_price=${max_price}`)
    .then(response => response.json())
    .then(data => {
      displayProducts(data);  // 商品を表示
    })
    .catch(error => {
      console.error('Error:', error);
    });
}

// 商品を画面に表示する関数
function displayProducts(products) {
  const productList = document.getElementById('product-list');
  const productCount = document.getElementById('product-count');
  productList.innerHTML = '';  // 既存の商品リストをクリア


   // 商品件数を更新
   productCount.textContent = `表示件数: ${products.length} 件`;


  // 商品データをループして表示
  products.forEach((item, index) => {
    const productElement = document.createElement('div');
    productElement.classList.add('product');

    // 商品詳細ページのリンクを作成
    const productLink = document.createElement('a');
    productLink.href = `/clothings/${item.id}`;  // clothing.idを使ってリンクを作成
    productLink.innerHTML = `
      <p>¥${item.price}</p>
      <img src="${item.image_url}" alt="Product Image">
    `;

    // 商品が表示される際に.visibleクラスを追加してアニメーションを開始
    productElement.appendChild(productLink);
    productList.appendChild(productElement);

    // 遅延を加えてクラスを追加 (インデックスに基づいて時間差をつける)
    setTimeout(() => {
      productElement.classList.add('visible');
    }, index * 180);  // 300msごとに時間差を設定
  });
}