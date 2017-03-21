class CustomerMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_mailer.forgot_password.subject
  #
  domain = 'example.com'
  default :charset => 'ISO-2022-JP', :from => "no-reply@#{domain}"

  def forgot_password(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "パスワード再登録の申請がありました。")
  end
end
