# 10.15 The generated User mailer previews.
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
	# 10.16 A working preview method for account activation.
  def account_activation
  	user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
	end

	# 10.46: A working preview method for password reset.
	# Preview this email at 
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

end
