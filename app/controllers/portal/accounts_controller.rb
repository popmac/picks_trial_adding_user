class Portal::AccountsController < Portal::Base
  def signup
    @token = AccountEmailToken.new
  end

  def send_mail
    @token = AccountEmailToken.new(token_params)
    if @token.save && VisitorMailer.confirm(@token).deliver_now
      flash.notice = 'メールアドレス認証メールを送信しました。'
      redirect_to [ :after_send, :portal, :accounts ]
    else
      flash.now[:alert] = "メールアドレス認証メールの送信に失敗しました。"
      render action: 'signup'
    end
  end

  def after_send
  end

  def new
    @token = AccountEmailToken.find_by(id: params[:id], value: params[:token])
    if @token && !@token.used && @token.within_time
      @user = User.new(email: @token.email)
    else
      token_error
    end
  end

  def create
    @token = AccountEmailToken.find_by(id: params[:id], value: params[:token])
    if @token && !@token.used && @token.within_time
      @user = User.new(user_params)
      if @user.save
        @token.token_used
        flash.notice = 'アカウントを登録しました。'
        redirect_to thanks_portal_accounts_path(id: @user.id)
      else
        flash.now[:alert] = "アカウント登録に失敗しました。"
        render action: 'new'
      end
    else
      token_error
    end
  end

  def thanks
    @user = User.find_by(id: params[:id])
  end

  private
  def token_params
    params.require(:account_email_token).permit(:email, :agreement)
  end

  def user_params
    params.require(:user).permit(
      :email, :family_name, :given_name, :family_name_kana, :given_name_kana,
      :new_password, :new_password_confirmation, :gender, :birthday, :company, :department, :official_position
    )
  end

  def token_error
    if !@token
      flash.alert = "無効なURLです。"
    elsif @token.used
      flash.alert = "このURLは使用済みです。"
    elsif !@token.within_time
      flash.alert = "このURLの有効期限は切れています。
        もう一度をメールアドレスを入力してください。"
    end
    redirect_to :portal_signup
  end
end
