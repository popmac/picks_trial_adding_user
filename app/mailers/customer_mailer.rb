class CustomerMailer < ActionMailer::Base
  domain = if Rails.env.production?
      'https://shielded-atoll-18636.herokuapp.com'
    else
      'example.com'
    end
  default :charset => 'ISO-2022-JP', :from => "no-reply@#{domain}"

  def forgot_password(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "パスワード再登録の申請がありました。")
  end
end
