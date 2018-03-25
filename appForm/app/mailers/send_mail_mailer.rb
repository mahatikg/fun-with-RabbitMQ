class SendMailMailer < ApplicationMailer
  default from: "mahatikg@gmail.com"

  def email(user)
    @user = user
    mail(to: @user.email, subject: 'insert receiver data here ')
  end
end
