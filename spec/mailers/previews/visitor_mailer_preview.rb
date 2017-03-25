# Preview all emails at http://localhost:3000/rails/mailers/visitor_mailer
class VisitorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/visitor_mailer/confirm
  def confirm
    token = AccountEmailToken.new(id: 1)
    token.email = 'hoge1@hoge.com'
    token.value = AccountEmailToken.create_salt
    VisitorMailer.confirm(token)
  end

end
