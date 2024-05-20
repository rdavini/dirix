class Driver < ApplicationRecord
  belongs_to :user
  has_many :working_days

  belongs_to :organization, class_name: 'Organization'

  # after_create_commit { MessageBroadcastJob.perform_later(self) }

  # after_validation :send_location

  # private
  # def send_location
  #   ActionCable.server.broadcast("DriversChannel",{
  #     id: 2,
  #     location: {lat: 10, lng: 20}
  #   })
  # end
end
