class DriversChannel < ApplicationCable::Channel
  def subscribed
    user = User.find params[:id]
    p "User #{params[:id]} trying to connect: #{user.name}"
    # channel_id =  user.role == "organization" ? user.id : user.driver.organization_id

    stream_from "drivers_channel"
    ActionCable.server.broadcast("drivers_channel", {email: user.email, message: "connected"}) unless user.role == "organization"
  end
 
  def unsubscribed
    user = User.find params[:id]
    # channel_id =  user.role == "organization" ? user.id : user.driver.organization_id

    ActionCable.server.broadcast("drivers_channel", {email: user.email, message: "disconnected"}) unless user.role == "organization"
    stop_all_streams
  end

  def receive(data)
    p "data:"
    p data
    ActionCable.server.broadcast("drivers_channel", {email: User.find(2).email, lat: data["lat"], lng: data["lng"]})
  end
end
