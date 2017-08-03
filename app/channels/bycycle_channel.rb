class BycycleChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bycycle_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def submit(data)
     ActionCable.server.broadcast 'bycycle_channel', message: data['message']
  end

end
