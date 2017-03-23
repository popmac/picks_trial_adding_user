class VisitorMailer < ActionMailer::Base
  domain = if Rails.env.production?
      'https://shielded-atoll-18636.herokuapp.com'
    else
      'example.com'
    end
  default :charset => 'ISO-2022-JP', :from => "no-reply@#{domain}"

  def confirm(account_email_token)
    @token = account_email_token
    mail(to: @token.email, subject: "アカウントの新規登録")
  end
end
