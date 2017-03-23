class VisitorMailer < ActionMailer::Base
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

  def confirm(account_email_token)
    @token = account_email_token
    mail(to: @token.email, subject: "アカウントの新規登録")
  end
end
