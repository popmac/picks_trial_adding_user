# Preview all emails at http://localhost:3000/rails/mailers/customer_mailer
class CustomerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/customer_mailer/forgot_password
  def forgot_password
    user = User.new
    user.email = 'hoge1@hoge.com'
    token = PasswordToken.new(id: 1)
    token.value = PasswordToken.create_salt
    CustomerMailer.forgot_password(user, token)
  end

end
