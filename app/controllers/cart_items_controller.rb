class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    clothing_id = params[:clothing_id]

    if user_signed_in?
      cart_item = @cart.cart_items.find_or_initialize_by(clothing_id: clothing_id)
      if cart_item.persisted?
        redirect_to cart_path, alert: "この商品はすでにカートに入っています"
      else
        cart_item.save
        redirect_to cart_path, notice: "商品をカートに追加しました"
      end
    else
      session[:cart] ||= {}
      if session[:cart].key?(clothing_id)
        redirect_to cart_path, alert: "この商品はすでにカートに入っています"
      else
        session[:cart][clothing_id] = 1
        redirect_to cart_path, notice: "商品をカートに追加しました"
      end
    end
  end

  def destroy
    clothing_id = params[:clothing_id]

    if user_signed_in?
      @cart.cart_items.find_by(clothing_id: clothing_id)&.destroy
    else
      session[:cart].delete(clothing_id)
    end

    redirect_to cart_path, notice: "商品を削除しました"
  end

  private

  def set_cart
    @cart = current_cart
  end
end
