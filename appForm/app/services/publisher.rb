module Publisher
require 'bunny'
require 'rubygems'
require 'json'

 AMQP_URL = 'amqp://ecxgsnig:ZYr8t6k6p2ADenifiNVc5Afiodmj-v_s@skunk.rmq.cloudamqp.com/ecxgsnig'



  def start_bunny
    #create a connection instance
  #   default_parameters = {
  #   :host => 'skunk.rmq.cloudamqp.com',
  #   :vhost => 	'ecxgsnig',
  #   :password => 'ZYr8t6k6p2ADenifiNVc5Afiodmj-v_s',
  #   :user => 'MeeruNilaya'
  # }

    @connection = Bunny.new(
      :host => 'skunk.rmq.cloudamqp.com',
      :vhost => 	'ecxgsnig',
      :password => 'cpaQAhJyOqHXSNfeRhyk0jzhxHV8JECS',
      :user => 'ecxgsnig'
    )
    # binding.pry
    #establish/start the connection
    @connection.start
    create_channel
  end

  def create_channel
    #create a channel for the TCP connection
    @channel = @connection.create_channel
    create_queue
  end

  def create_queue
    #declare a queue and give it a name on this channel
    @queue = @channel.queue("MG")


    create_exchange
  end

  def create_exchange
    #create a direct exchange
    @exchange = @channel.direct("MGexchange", :durable => true)
    #bind exchange to the queue
    @queue.bind(@exchange, :routing_key => "MGprocess")

  end

  def publish(submission)
  start_bunny
  #publish the the 'submission' (the variable storing the event and payload) to the
  #queue and routing key previously declared
    @exchange.publish("submission", :key => 'MG', :timestamp => Time.now.to_i, :routing_key => "MGprocess")
    sleep 1.0
    @connection.close
  end

end
