class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  # deviseのパラメータにbirthdayを結合する処理
  def update_resource(resource, params)
    if params[:birthday].is_a?(Array) && params[:birthday].length == 3
      # 年月日から日付を作成してbirthdayに設定
      params[:birthday] = Date.new(*params[:birthday].map(&:to_i))
    end
    super(resource, params)
  end
end
