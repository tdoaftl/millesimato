class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :clothing 

  validates :clothing_id, uniqueness: { scope: :cart_id }  # 同じ商品は1つまで
end
