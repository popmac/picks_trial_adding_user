class Customer::Base < ApplicationController
  before_action :authorize

  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  helper_method :current_user

  def authorize
    unless current_user
      flash.notice = 'ログインしてください'
      redirect_to :customer_login
    end
  end
end
