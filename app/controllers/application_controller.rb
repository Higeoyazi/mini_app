class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインアウト後にログイン画面にする処理
  def after_sign_out_path_for(resource)
    '/' # サインアウト後のリダイレクト先URL(新)
    # '/users/sign_in' # サインアウト後のリダイレクト先URL(旧)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
  end
end
