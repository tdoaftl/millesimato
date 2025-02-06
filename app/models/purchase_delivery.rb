class PurchaseDelivery
  include ActiveModel::Model

  # 属性
  attr_accessor :user_id, :clothing_id, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code,
                :prefecture_id, :city, :address, :building, :phone_number, :update_information, :token


     with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
         validates :last_name,        presence: true
         validates :first_name,         presence: true
                 end
     with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' } do
        validates :last_name_kana,        presence: true
         validates :first_name_kana,         presence: true
                    end
    with_options presence: true do
      validates :token
      validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows(e.g. 123-4567)"}
      validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
      validates :city
      validates :address
      validates :phone_number, length: { minimum: 10,maximum: 11, message: 'is too short'}
      validates :user_id
      validates :clothing_id
    end
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Input only number'}
    
  def save
    # 購入情報を保存
    purchase = Purchase.create(user_id: user_id, clothing_id: clothing_id)

    # 配送先情報を保存
    Delivery.create(
      purchase_id: purchase.id,
      last_name: last_name,
      first_name: first_name,
      last_name_kana: last_name_kana,
      first_name_kana: first_name_kana, 
      post_code: post_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number
    )

    # チェックボックスがオンの場合、ユーザー情報を更新
    if update_information == '1'
      information = Information.find_or_initialize_by(user_id: user_id)
      information.update(
        last_name: last_name,
        first_name: first_name,
        last_name_kana: last_name_kana,
        first_name_kana: first_name_kana, 
        post_code: post_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building: building,
        phone_number: phone_number
      )
    end
  end
end