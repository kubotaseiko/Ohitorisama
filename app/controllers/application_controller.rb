class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about, :show, :index]
  before_action :configure_permitted_parameters, if: :devise_controller?

   #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_users_path
    when User
      shops_path
    end
  end

  #ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

end
