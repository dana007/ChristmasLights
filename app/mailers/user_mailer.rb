class UserMailer < ApplicationMailer
  default from: 'christmastlights@nipun&dana.com'

  def password_reset_email(email, user_id)
    mail(to: email,
         body: update_password_user_url(user_id),
         content_type: 'text/html',
         subject: 'Christmas Lights Password Reset Link')
  end

end
