class Clothing < ApplicationRecord
  has_one_attached :image
  has_many :purchase
  belongs_to :user
  has_many :favorites

   # 商品ステータス    表示: 0, 非表示: 1
   enum visibility: { visible: 0, hidden: 1 }  

  def sold?
    purchase.present?  # Purchaseテーブルに紐づくレコードがあるかどうか
  end

    # ユーザーがお気に入りにしているかどうか
    def has_favorite?
      favorite_clothings.exists?
    end

  def invisible?   #非表示かどうか
    hidden?
  end

  def favorite_by?(user)     #お気に入り済みかどうか
    favorites.where(user_id: user.id).exists?
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


  validates :price,           presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100000 }

end
