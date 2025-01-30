# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "card", to: "card.js"
pin "select_checkbox", to: "select_checkbox.js"
pin "price_slider", to: "price_slider.js"
pin "word_search", to: "word_search.js"
pin "brand_pulldown", to: "brand_pulldown.js"
pin "total", to: "total.js"