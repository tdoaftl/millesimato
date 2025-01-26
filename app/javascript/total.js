document.addEventListener('DOMContentLoaded', () => {
  const filters = {
    searchWord: '',
    priceRange: { min: 0, max: 50000 },
    checkboxFilters: {},
  };

  document.addEventListener('wordUpdated', (event) => {
    filters.searchWord = event.detail.searchWord;
    updateProducts();
  });

  document.addEventListener('priceUpdated', (event) => {
    filters.priceRange = {
      min: event.detail.minPrice,
      max: event.detail.maxPrice,
    };
    updateProducts();
  });

  document.addEventListener('checkboxUpdated', (event) => {
    const { filterType, value, isChecked } = event.detail;

    if (!filters.checkboxFilters[filterType]) {
      filters.checkboxFilters[filterType] = [];
    }

    if (isChecked) {
      if (!filters.checkboxFilters[filterType].includes(value)) {
        filters.checkboxFilters[filterType].push(value);
      }
    } else {
      filters.checkboxFilters[filterType] = filters.checkboxFilters[filterType].filter(
        (v) => v !== value
      );
    }

    updateProducts();
  });

  updateProducts();

  function updateProducts() {
    if (!filters.checkboxFilters.brand) {
      filters.checkboxFilters.brand = [];
    }
    if (!filters.checkboxFilters.made_in) {
      filters.checkboxFilters.made_in = [];
    }
    if (filters.searchWord === null) {
      filters.searchWord = '';
    }

    fetch('/clothings/search_all', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify(filters),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        const productList = document.getElementById('product-list');

        productList.innerHTML = ''; // 既存の商品リストをクリア

        if (!data || data.length === 0) {
          productList.innerHTML = '<p>No products found</p>';
          return;
        }

        // 商品リストを描画
        data.forEach((item, index) => {
          const productElement = document.createElement('div');
          productElement.classList.add('product-animation');

          const productLink = document.createElement('a');
          productLink.href = `/clothings/${item.id}`;
          productLink.innerHTML = `
            <p>¥${item.price}</p>
            <img src="${item.image_url}" alt="Product Image">
          `;

          productElement.appendChild(productLink);
          productList.appendChild(productElement);

          // 遅延を加えてクラスを追加 (インデックスに基づいて時間差をつける)
          requestAnimationFrame(() => {
            setTimeout(() => {
              productElement.classList.add('visible');
            }, index * 180); // 時間差アニメーション
          });
        });
      })
      .catch((error) => console.error('Error fetching products:', error));
  }
});


