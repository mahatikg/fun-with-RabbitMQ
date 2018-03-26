class EmailMailer < ApplicationMailer
  default from: "mahatikg@gmail.com"

  def email(message_data)
    mail(to: message_data["email"], subject: 'hello!').deliver_now
    puts "THE EMAIL #{data.email} "
  

  end
end
