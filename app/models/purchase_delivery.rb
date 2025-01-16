class PurchaseDelivery
  include ActiveModel::Model

  # 属性
  attr_accessor :user_id, :clothing_id, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code,
                :prefecture_id, :city, :address, :building, :phone_number, :update_information, :token


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