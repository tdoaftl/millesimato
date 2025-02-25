class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :clothing

  def sold?
    purchase.present?  # Purchaseテーブルに紐づくレコードがあるかどうか
  end
end
