require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'create address should be valid' do
    expect( create(:address) ).to be_valid
  end

  it "null street is not valid" do
    expect{ create(:address, street: nil) }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "null number is not valid" do
    expect{ create(:address, number: nil) }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "null block is not valid" do
    expect{ create(:address, block: nil) }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "null city is not valid" do
    expect{ create(:address, city: nil) }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "null country is not valid" do
    expect{ create(:address, country: nil) }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "null state is not valid" do
    expect{ create(:address, state: nil) }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "null zip is not valid" do
    expect{ create(:address, zip: nil) }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "null location is not valid" do
    expect{ create(:address, number: nil, state: nil, city: nil, country: nil, location: nil) }.to raise_error(NoMethodError)
  end

  it "street size must be ge 1" do
    expect{  create(:address, street: "") }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it "state size must be equal 2" do
    expect{  create(:address, state: "a") }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it "state size must be equal 2" do
    expect{  create(:address, state: "abc") }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it "number must be positive" do
    expect{  create(:address, number: -1) }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it "record must be unique" do
    create(:address, street: "assis figueiredo", number: 10, complement: "", block: "centro", city: "pocos de caldas")
    expect{  create(:address, street: "assis figueiredo", number: 10, complement: "", block: "centro", city: "pocos de caldas") }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
