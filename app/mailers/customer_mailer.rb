class CustomerMailer < ActionMailer::Base
  domain = if Rails.env.production?
      'heroku.com'
    else
      'example.com'
    end

  if Rails.env.production?
    default from: "no-reply@#{domain}"
  else
    default :charset => 'ISO-2022-JP', :from => "no-reply@#{domain}"
  end

  def forgot_password(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "パスワード再登録の申請がありました。")
  end
end
