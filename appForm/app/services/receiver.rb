module Receiver
require "rubygems"
require "bunny"
require "json"
# require 'SendMailMailer'
# include Publisher
  def start_receiver_connection
    binding.pry
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

# Method for the PDF processing
  def pdf_processing(json_information_message)
    binding.pry
    SendMailMailer.new.email(json_information_message)
    sleep 20.0

    @connection.close
    puts "connection closed"

  end

  def subscribe
   # consumer to subscribe to the queue that is being published to
       @queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|

        puts "this is the payload: #{payload}"
        json_information_message = JSON.parse(payload)
              binding.pry
              puts "#{json_information_message}"
        pdf_processing(json_information_message)
      end

  end

end
