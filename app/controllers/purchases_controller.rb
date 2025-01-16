class PurchasesController < ApplicationController
  def new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @clothing = Clothing.find(params[:clothing_id])
    user_information = current_user.information
    @purchase_delivery = PurchaseDelivery.new(
      user_id: current_user.id,
      clothing_id: @clothing.id,
      last_name: user_information&.last_name,
      first_name: user_information&.first_name,
      last_name_kana: user_information&.last_name_kana,
      first_name_kana: user_information&.first_name_kana,
      post_code: user_information&.post_code,
      prefecture_id: user_information&.prefecture_id,
      city: user_information&.city,
      address: user_information&.address,
      building: user_information&.building,
      phone_number: user_information&.phone_number
    )
  end

  def create
    @clothing = Clothing.find(params[:clothing_id])
    @purchase_delivery = PurchaseDelivery.new(purchase_delivery_params)
    if @purchase_delivery.valid?
      pay_item
      @purchase_delivery.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :new
    end
  end

  private

  def purchase_delivery_params
    params.require(:purchase_delivery).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :post_code, :prefecture_id, :city, :address, :building, :phone_number, :update_information
    ).merge(user_id: current_user.id, clothing_id: @clothing.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @clothing.price,  # 商品の値段
      card: purchase_delivery_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )

  end
end

