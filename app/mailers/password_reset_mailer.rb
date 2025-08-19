class PasswordResetMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def reset_email(user)
    @user = user
    mail(to: @user.email, subject: "パスワード再設定")
  end
end
