class Portal::AccountsController < ApplicationController
  def signup
    @token = AccountEmailToken.new
  end

  def send_mail
    @token = AccountEmailToken.new(token_params)
    if @token.save && UserMailer.confirm(@token).deliver_now
      flash.notice = 'メールアドレス認証メールを送信しました。'
      redirect_to [ :after_send, :portal, :accounts ]
    else
      flash.now[:alert] = "メールアドレス認証メールの送信に失敗しました。"
      render action: 'signup'
    end
  end

  private
  def token_params
    params.require(:account_email_token).permit(:email)
  end
end
