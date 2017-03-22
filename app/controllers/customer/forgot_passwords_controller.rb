class Customer::ForgotPasswordsController < Customer::Base
  skip_before_action :authorize

  def new
    @form = Customer::ForgotPasswordForm.new
  end

  def create
    @form = Customer::ForgotPasswordForm.new(form_params)
    if @form.email.present?
      @user = User.find_by(
        email_for_index: @form.email.downcase)
    end
    if @user.present?
      if @user.suspended?
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      elsif !@user.active?
        flash.now.alert = 'アカウントが削除済みです'
        render action: 'new'
      else
        @token = PasswordToken.new(user_id: @user.id)
        if @token.save && CustomerMailer.forgot_password(@user, @token).deliver_now
          flash.notice = 'メールを送信しました。'
          redirect_to :after_send_customer_forgot_password
        else
          flash.now.alert = 'メールの送信に失敗しました。'
          render action: 'new'
        end
      end
    else
      flash.now.alert = 'メールアドレスが正しくありません。'
      render action: 'new'
    end
  end

  def after_send
  end

  def input_password
    @token = PasswordToken.find_by(id: params[:id], value: params[:token])
    if @token && !@token.used && @token.within_time
      @user = @token.user
    else
      token_error
    end
  end

  def change_password
    @token = PasswordToken.find_by(id: params[:id], value: params[:token])
    if @token && !@token.used && @token.within_time
      @user = @token.user
      @user.assign_attributes(user_params)
      if @user.save && @token.token_used
        flash.notice = 'パスワードを更新しました。'
        redirect_to :customer_login
      else
        flash.now[:alert] = 'パスワードの更新に失敗しました。'
        render action: 'input_password'
      end
    else
      token_error
    end
  end

  private
  def form_params
    params.require(:customer_forgot_password_form).permit(:email)
  end

  def user_params
    params.require(:user).permit(:new_password, :new_password_confirmation)
  end

  def token_error
    if !@token
      flash.alert = "無効なURLです。"
    elsif @token.used
      flash.alert = "このURLは使用済みです。"
    elsif !@token.within_time
      flash.alert = "このURLの有効期限は切れています。
      もう一度URLを発行してください。"
    end
    redirect_to :new_customer_forgot_password
  end
end
