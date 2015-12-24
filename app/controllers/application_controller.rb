class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def authenticate_user!
    if params[:authentication_token]
      usr = User.find_by(id: params[:user_id], authentication_token: params[:authentication_token])
      if usr
        sign_in(usr)
      else
        sign_out
        render json: {status: 503, message: "Access Denied"}
        return false
      end
    else
      super
    end
  end
end
