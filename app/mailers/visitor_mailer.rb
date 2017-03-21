class VisitorMailer < ActionMailer::Base
  # domain = if Rails.env.production? || Rails.env.staging?
  #     'inober.com'
  #   else
  #     'example.com'
  #   end
  domain = 'example.com'
  default :charset => 'ISO-2022-JP', :from => "no-reply@#{domain}"

  def confirm(account_email_token)
    @token = account_email_token
    mail(to: @token.email, subject: "アカウントの新規登録")
  end
end
