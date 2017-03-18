# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/confirm
  def confirm
    token = AccountEmailToken.new
    token.email = 'hoge1@hoge.com'
    token.value = AccountEmailToken.create_salt
    UserMailer.confirm(token)
  end

end
