class Publisher


#method to grab the fanout exchange and publish the message
  def self.publish(exchange, message= {})
    x = channel.fanout("appForm.#{exchange}")
    x.publish(message.to_json)
  end

  def self_channel
    @channel || = connection.create_channel
  end

  def self.connection
    connection || = Bunny.new.tap do |c|
      c.start
    end 
  end
end
