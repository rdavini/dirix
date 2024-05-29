class ApiKey < ApplicationRecord
  belongs_to :user

  validates :ip, presence: true, format: { with: /\A(?:[0-9]{1,3}\.){3}[0-9]{1,3}\z/,  message: "Invalid IP format" }
  validates :token, presence: true, uniqueness: {scope: :ip, message: "This key has already been associated with this IP"}
  before_validation :generate_token, on: :create
  encrypts :token, deterministic: true

  private

  def generate_token
    self.token = Digest::MD5.hexdigest(SecureRandom.hex)
  end  
end
