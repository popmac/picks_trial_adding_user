class Customer::Base < ApplicationController
  before_action :authorize
  before_action :check_account

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

  def check_account
    if current_user && current_user.suspended?
      session.delete(:user_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :portal_root
    end
  end
end
