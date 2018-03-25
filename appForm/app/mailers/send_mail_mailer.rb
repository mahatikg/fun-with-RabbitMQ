class SendMailMailer < ApplicationMailer
  default from: "mahatikg@gmail.com"

  def email(data)
    binding.pry
    mail(to: data.email, subject: 'hello').deliver_now
    binding.pry
    puts "THE EMAIL #{data.email} "

  end
end
