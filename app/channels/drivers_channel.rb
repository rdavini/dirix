class DriversChannel < ApplicationCable::Channel
  def subscribed
    p "User #{current_user.id} trying to connect"

    stream_from channel_name
    ActionCable.server.broadcast(channel_name, {email: current_user.email, message: "connected"}) unless current_user.role == "organization"
  end
 
  def unsubscribed
    ActionCable.server.broadcast(channel_name, {email: current_user.email, message: "disconnected"}) unless current_user.role == "organization"
    stop_all_streams
  end

  def receive(data)
    p "data:"
    p data
    ActionCable.server.broadcast(channel_name, {email: data["email"], lat: data["lat"], lng: data["lng"]})
  end

  private
  def channel_name
    "drivers_channel_#{current_user.role == "organization" ? current_user.id : current_user.driver.organization_id}"
  end
end
