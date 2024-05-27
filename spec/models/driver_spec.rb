require 'rails_helper'

RSpec.describe Driver, type: :model do
  it "null avg_speed is not valid" do
    expect{ create(:driver, avg_speed: nil, organization: Organization.new) }.to raise_error(ActiveRecord::NotNullViolation)
  end
end
