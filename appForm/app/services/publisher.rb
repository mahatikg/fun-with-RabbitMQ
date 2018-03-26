module Publisher
require 'bunny'
require 'rubygems'
require 'json'
include Receiver

 # AMQP_URL = 'amqp://ecxgsnig:ZYr8t6k6p2ADenifiNVc5Afiodmj-v_s@skunk.rmq.cloudamqp.com/ecxgsnig'

#setups a new connection using the Bunny gem
  def start_bunny
    @connection = Bunny.new(
      :host => 'skunk.rmq.cloudamqp.com',
      :vhost => 	'ecxgsnig',
      :password => 'cpaQAhJyOqHXSNfeRhyk0jzhxHV8JECS',
      :user => 'ecxgsnig'
    )
    #after detailing the various parameters to define the connection launch the connection
    @connection.start
    create_channel
  end

  def create_channel
    #create a channel within the just created connection
    @channel = @connection.create_channel
    create_queue
  end

  def create_queue
    #declare a queue and give it a name within this channel to be indentified by
    @queue = @channel.queue("MGexchange")
    create_exchange
  end

  def create_exchange
    #enables this queue to be connected to single consumer (fanout for multiple consumers)
    @exchange = @channel.direct("MGexchange", :durable => true)
    #bind exchange to the queue
    @queue.bind(@exchange, :routing_key => "MGprocess")
  end


  def publish(submission)
    #this method is called from the controller with the data the user submit
    start_bunny
    #after creating the proper passageway and sending the data, calls subscribe method in reciever module
    subscribe
    sent_message =  @exchange.publish(submission.to_json, :timestamp => Time.now.to_i, :routing_key => "MGprocess")
  end


end
