document.addEventListener("turbo:load", function() {
  const toggle = document.getElementById("visibility_toggle");
  const label = document.getElementById("toggle-label");
  const productImageWrapper = document.querySelector('.clothing-image-wrapper'); // 商品画像ラッパー
  const productImage = productImageWrapper ? productImageWrapper.querySelector('img') : null; // 商品画像
  
  // 初期状態で非表示ラベルを更新
  updateVisibilityLabel();

  if (toggle) {
    toggle.addEventListener("change", function() {
      const clothingId = this.dataset.clothingId;  // 商品のIDを取得
      const visibility = this.checked ? "visible" : "hidden";  // トグルの状態によって visibility を設定

      // サーバーに visibility の状態を更新する
      fetch(`/clothings/${clothingId}/toggle_visibility`, {
        method: "PATCH",  
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ visibility: visibility }) // visibility の値を JSON で送信
      })
      .then(response => response.json())
      .then(data => {
        // トグルの状態に応じてラベルを更新
        label.textContent = data.visibility === "visible" ? "表示" : "非表示";

        // 非表示ラベルを切り替える
        updateVisibilityLabel();
        
        // 画像を薄くするか元に戻す
        if (productImage) {
          if (visibility === "hidden") {
            productImage.classList.add('hidden-image');
          } else {
            productImage.classList.remove('hidden-image');
          }
        }
      })
      .catch(error => console.error("Error:", error));
    });
  }

  // 非表示ラベルを追加または削除
  function updateVisibilityLabel() {
    if (toggle.checked) {
      // 表示状態の場合、非表示ラベルを削除
      const invisibleLabel = productImageWrapper.querySelector('.hidden-badge');
      if (invisibleLabel) {
        invisibleLabel.remove();
      }
    } else {
      // 非表示状態の場合、非表示ラベルを追加
      if (!productImageWrapper.querySelector('.hidden-badge')) {
        const invisibleLabel = document.createElement('div');
        invisibleLabel.classList.add('hidden-badge');
        invisibleLabel.innerText = 'invisible';
        productImageWrapper.appendChild(invisibleLabel);
      }
    }
  }
});
