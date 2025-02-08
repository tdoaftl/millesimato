document.addEventListener('DOMContentLoaded', () => {
  // 初期フィルタ設定
  const filters = {
    searchWord: '', // 検索ワード
    priceRange: { min: 0, max: 100000 }, // 価格範囲の初期値
    checkboxFilters: {}, // チェックボックスフィルタ（カテゴリーやブランドなど）
  };

  // 'wordUpdated' イベントリスナー（検索ワードが更新されたとき）
  document.addEventListener('wordUpdated', (event) => {
    filters.searchWord = event.detail.searchWord; // 検索ワードを更新
    updateProducts(); // 商品リストを更新
  });

  // 'priceUpdated' イベントリスナー（価格範囲が更新されたとき）
  document.addEventListener('priceUpdated', (event) => {
    filters.priceRange = { 
      min: event.detail.minPrice, // 最小価格
      max: event.detail.maxPrice, // 最大価格
    };
    updateProducts(); // 商品リストを更新
  });

  // 'checkboxUpdated' イベントリスナー（チェックボックスのフィルタが更新されたとき）
  document.addEventListener('checkboxUpdated', (event) => {
    const { filterType, value, isChecked } = event.detail; // チェックボックスの状態（フィルタタイプ、値、状態）

    // フィルタタイプが未定義の場合、初期化
    if (!filters.checkboxFilters[filterType]) {
      filters.checkboxFilters[filterType] = [];
    }

    // チェックされている場合、その値をフィルタに追加
    if (isChecked) {
      if (!filters.checkboxFilters[filterType].includes(value)) {
        filters.checkboxFilters[filterType].push(value);
      }
    } else {
      // チェックが外された場合、その値をフィルタから削除
      filters.checkboxFilters[filterType] = filters.checkboxFilters[filterType].filter(
        (v) => v !== value
      );
    }

    updateProducts(); // 商品リストを更新
  });

  // 初期化時に商品リストを更新
  updateProducts();

  // 商品リストを更新する関数
  function updateProducts() {
    // 各フィルタタイプが未定義の場合、空配列で初期化
    if (!filters.checkboxFilters.brand) {
      filters.checkboxFilters.brand = [];
    }
    if (!filters.checkboxFilters.category) {
      filters.checkboxFilters.category = [];
    }
    if (!filters.checkboxFilters.gender) {
      filters.checkboxFilters.gender = [];
    }
    if (!filters.checkboxFilters.era) {
      filters.checkboxFilters.era = [];
    }
    if (!filters.checkboxFilters.color) {
      filters.checkboxFilters.color = [];
    }
    if (!filters.checkboxFilters.size) {
      filters.checkboxFilters.size = [];
    }
    if (!filters.checkboxFilters.condition) {
      filters.checkboxFilters.condition = [];
    }
    if (!filters.checkboxFilters.material) {
      filters.checkboxFilters.material = [];
    }
    if (!filters.checkboxFilters.made_in) {
      filters.checkboxFilters.made_in = [];
    }

    // 検索ワードが null の場合、空文字列に設定
    if (filters.searchWord === null) {
      filters.searchWord = '';
    }

    // サーバーにフィルタ情報を送信し、商品リストを取得
    fetch('/clothings/search_all', {
      method: 'POST', // POSTリクエスト
      headers: {
        'Content-Type': 'application/json', // リクエストヘッダー（JSON形式）
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content, // CSRFトークン
      },
      body: JSON.stringify(filters), // フィルタ情報をリクエストボディに含める
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`); // エラーチェック
        }
        return response.json(); // レスポンスをJSON形式に変換
      })
      .then((data) => {
        const productList = document.getElementById('product-list'); // 商品リストの要素を取得

        productList.innerHTML = ''; // 既存の商品リストをクリア

        // 商品が存在しない場合の処理
        if (!data || data.length === 0) {
          productList.innerHTML = '<p>No products found</p>'; // 商品が見つからなかった場合
          return;
        }

        // 商品リストを描画
        data.forEach((product, index) => {
          // 商品ごとのHTML要素を作成
          const productElement = document.createElement('div');
          productElement.classList.add('product-item'); // アニメーション用クラスを追加
        
          // 商品リンクを作成
          const productLink = document.createElement('a');
          productLink.href = `/clothings/${product.id}`;
        
          // 画像と価格を商品リンクに追加
          productLink.innerHTML = `
            <div class="clothing-image-wrapper">
              <img src="${product.image_url || '/images/dummy.png'}" alt="dummy.png"> <!-- 商品画像 -->
              <p style="font-weight: bold;">¥${product.price}</p> <!-- 価格 -->
            </div>
          `;
        
          // 商品が売り切れの場合に SOLD ラベルを追加
          if (product.sold) {  // product.soldがtrueならSOLDラベルを表示
            const soldLabel = document.createElement('div');
            soldLabel.classList.add('sold-label'); // CSSクラスを追加
            soldLabel.innerText = 'SOLD';  // ラベルのテキストを設定
        
            // 商品画像をラッパーで囲んで SOLD ラベルを画像の上に追加
            const imageWrapper = productLink.querySelector('.clothing-image-wrapper');
            imageWrapper.appendChild(soldLabel); // SOLDラベルを画像の上に追加
          }
        

          // 商品が非表示の場合 非表示 ラベルを追加
if (product.invisible) {  // product.invisibleがtrueなら非表示ラベルを表示
  const invisibleLabel = document.createElement('div');
  invisibleLabel.classList.add('hidden-badge'); // CSSクラスを追加
  invisibleLabel.innerText = 'invisible';  // ラベルのテキストを設定

  // 商品画像をラッパーで囲んで 非表示 ラベルを画像の上に追加
  const imageWrapper = productLink.querySelector('.clothing-image-wrapper');
  imageWrapper.appendChild(invisibleLabel); // 非表示ラベルを画像の上に追加

  // 画像を透明にする
  const image = imageWrapper.querySelector('img');  // 商品画像を取得
  if (image) {
    image.classList.add('hidden-image'); // 画像に透明度を適用するクラスを追加
  }

}
        
          productElement.appendChild(productLink); // 商品リンクを商品要素に追加
          productList.appendChild(productElement); // 商品要素を商品リストに追加
        
          // 遅延を加えてアニメーションを開始（インデックスに基づいて時間差をつける）
          requestAnimationFrame(() => {
            setTimeout(() => {
              productElement.classList.add('visible'); // 'visible' クラスを追加して表示
            }, index * 180); // 商品ごとに時間差をつけて表示
          });
        });
        
        
      })
      .catch((error) => console.error('Error fetching products:', error)); 
  }
});
