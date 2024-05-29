require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  # it "api_key creation should be valid" do
  #   expect( create(:api_key) ).to be_valid
  # end

  # it "null user is not valid" do
  #   expect( build(:api_key, user: nil) ).to_not be_valid
  # end

  # it "null ip is not valid" do
  #   expect{ create(:api_key, ip: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  # end

  # it "ip length too long" do
  #   expect{ create(:api_key, ip: SecureRandom.hex(40)) }.to raise_error(ActiveRecord::RecordInvalid)
  # end

  # it "ip format is not valid" do
  #   expect{ create(:api_key, ip: "abc") }.to raise_error(ActiveRecord::RecordInvalid)
  # end
end
