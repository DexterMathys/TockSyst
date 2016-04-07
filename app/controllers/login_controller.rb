class LoginController < ApplicationController

  before_filter :authenticate_user!

  def index
  end
  def login
    if user = User.find_by(params[:username], params[:password])
      session[:current_user_id] = user.id
      redirect_to root_url
    else
      redirect_to '/users/sign_in'
    end
  end

  def new

  end
end
