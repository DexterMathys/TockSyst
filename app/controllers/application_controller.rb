class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def after_sign_in_path_for(user)
    session[:id] = current_user.id
    root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, flash: {error: exception.message}
  end

end
