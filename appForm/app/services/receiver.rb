module Receiver
require "rubygems"
require "bunny"
require "json"

  def start_connection
    @conn = Bunny.new ENV['AMQP_URL']
    # The connection will be established when start is called
    conn.start
    access_channel
  end

  def access_channel
  # Create a channel in the TCP connection
    @channel = @conn.create_channel
    # Declare a queue with a given name, examplequeue. In this example is a durable shared queue used.
    @queue = @channel.queue("MG", :durable => true)
    pdf_processing
  end
# Method for the PDF processing
  def pdf_processing(json_information_message)
    puts json_information_message['email']
    sleep 5.0
    puts "pdf processing done"
  end

  def subscribe
   # consumer to subscribe to the queue that is being published to
       q.subscribe(:block => true) do |delivery_info, properties, payload|
        json_information_message = JSON.parse(payload)
        pdf_processing(json_information_message)
      end

  end

  def email
    #method to pass payload to email 
  end

end
