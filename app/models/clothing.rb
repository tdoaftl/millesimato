class Clothing < ApplicationRecord
  has_one_attached :image
  has_many :purchase
  belongs_to :user

   # 商品ステータス    表示: 0, 非表示: 1
   enum visibility: { visible: 0, hidden: 1 }  

  def sold?
    purchase.present?  # Purchaseテーブルに紐づくレコードがあるかどうか
  end


  def invisible?   #非表示かどうか
    hidden?
  end

 


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :brand
  belongs_to :era
  belongs_to :gender
  belongs_to :category
  belongs_to :condition
  belongs_to :size
  belongs_to :color
  belongs_to :material
  belongs_to :made_in


end
