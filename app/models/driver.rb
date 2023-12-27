class Driver < ApplicationRecord
  belongs_to :user
  has_many :working_days

  belongs_to :organization, class_name: 'Organization'
end
