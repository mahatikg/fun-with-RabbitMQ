module Publisher

 AMQP_URL = 'amqp://ecxgsnig:ZYr8t6k6p2ADenifiNVc5Afiodmj-v_s@skunk.rmq.cloudamqp.com/ecxgsnig'
require 'bunny'


  def start_bunny
    @bunny = Bunny.new ENV['AMQP_URL']
    @bunny.start
  end

  def create_channel
    @channel = @bunny.create_channel
  end

  def create_queue
    queue = @channel.queue("MG")
  end

  def create_exchange
    @exchange = @channel.exchange("")
  end

  def self.to_publish(submission)
    @exchange.publish("submission", :key => 'MG')
  end


end

#method to grab the fanout exchange and publish the message
#   def self_channel
#     @channel ||= connection.create_channel
#   end
#
#   def self.publish(exchange, message= {})
#     x = channel.fanout("appForm.#{exchange}")
#     x.publish(message.to_json)
#   end
#
#
#
#   def self.connection
#     connection ||= Bunny.new.tap do |c|
#       c.start
#     end
#   end
# end
