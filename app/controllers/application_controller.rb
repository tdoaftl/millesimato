class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

# basic認証
private
def basic_auth
  authenticate_or_request_with_http_basic do |username, password|
    username == ENV["ADMIN_USER"] && password == ENV["ADMIN_PASSWORD"]
  end
end
end