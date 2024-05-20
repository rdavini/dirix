class DriversChannel < ApplicationCable::Channel
  def subscribed
    user = User.find params[:id]
    channel_id =  user.role == "organization" ? user.id : user.driver.organization_id    

    stream_from "drivers_channel_#{channel_id}"    
    ActionCable.server.broadcast("drivers_channel_#{channel_id}", {email: user.email, message: "connected"}) unless user.role == "organization"
  end
 
  def unsubscribed
    user = User.find params[:id]
    channel_id =  user.role == "organization" ? user.id : user.driver.organization_id    

    ActionCable.server.broadcast("drivers_channel_#{channel_id}", {email: user.email, message: "disconnected"}) unless user.role == "organization"
    stop_all_streams
  end

  def receive(data)
    # Handle the received data here
    location = data["location"]
  end

end
