module Receiver
require "rubygems"
require "bunny"
require "json"
# require 'SendMailMailer'
# include Publisher
  def start_receiver_connection
    @conn = Bunny.new(
      :host => 'skunk.rmq.cloudamqp.com',
      :vhost => 	'ecxgsnig',
      :password => 'cpaQAhJyOqHXSNfeRhyk0jzhxHV8JECS',
      :user => 'ecxgsnig'
    )

    @conn.start
    access_channel

  end

  def access_channel
    subscribe
  end

#takes the parsed data from the subscribe method and sends it to the mailer
  def data_processing(message_data)
    EmailMailer.new.email(message_data)

  end

  def subscribe
       @queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|

        puts "this is the payload: #{payload}"
        message_data = JSON.parse(payload)
              binding.pry
              puts "#{message_data}"
        data_processing(message_data)
        #once the data is sent to the mailer to send an email the connection can close
        @conn.close
      end

  end

end
