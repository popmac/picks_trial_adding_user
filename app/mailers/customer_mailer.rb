class CustomerMailer < ActionMailer::Base
  # domain = if Rails.env.production? || Rails.env.staging?
  #     'inober.com'
  #   else
  #     'example.com'
  #   end
  domain = 'example.com'
  default :charset => 'ISO-2022-JP', :from => "no-reply@#{domain}"

  def forgot_password(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "パスワード再登録の申請がありました。")
  end
end
