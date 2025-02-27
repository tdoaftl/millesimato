class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_cart

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  def current_cart
    if user_signed_in?
      cart = current_user.cart || current_user.create_cart
      cart.clear_if_expired
      session_cart = session[:cart]
      if session_cart.present?
        merge_cart(session_cart, cart)
        session[:cart] = nil
      end
      cart
    else
      session[:cart] ||= {}
    end
  end

# basic認証
private
def basic_auth
  authenticate_or_request_with_http_basic do |username, password|
    username == ENV["ADMIN_USER"] && password == ENV["ADMIN_PASSWORD"]
  end
end

def merge_cart(session_cart, user_cart)
  session_cart.each do |clothing_id, _|
    user_cart.cart_items.find_or_create_by(clothing_id: clothing_id)
  end
end

end