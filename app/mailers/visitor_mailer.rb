class VisitorMailer < ActionMailer::Base
  domain = if Rails.env.production?
      'heroku.com'
    else
      'example.com'
    end
  default from: "no-reply@#{domain}"

  def confirm(account_email_token)
    @token = account_email_token
    mail(to: @token.email, subject: "アカウントの新規登録")
  end
end
