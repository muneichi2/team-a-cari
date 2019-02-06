class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: %i(index show)
  before_action :configure_permitted_parameters, if: :devise_controller?

  Image_count = 4
  Commission = 0.1

  private
  def production?
    Rails.env.production?
  end

# RailsアプリへのBasic認証導入用,環境変数
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
