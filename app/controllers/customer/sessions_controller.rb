class Customer::SessionsController < Customer::Base
  def new
    if current_user
      redirect_to :customer_root
    else
      @form = Customer::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Customer::LoginForm.new(customer_login_form_params)
    if @form.email.present?
      user = User.find_by(email_for_index: @form.email.downcase)
    end
    if Customer::Authenticator.new(user).authenticate(@form.password)
      if user.suspended?
        flash.alert = 'アカウントが停止されています'
        render action: 'new'
      elsif user.deleted?
        flash.alert = 'アカウントは削除済みです'
        render action: 'new'
      else
        session[:user_id] = user.id
        flash.notice = 'ログインしました'
        redirect_to :customer_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash.notice = 'ログアウトしました'
    redirect_to :portal_root
  end

  private
  def customer_login_form_params
    params.require(:customer_login_form).permit(:email, :password)
  end
end
