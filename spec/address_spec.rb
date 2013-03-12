require 'spec_helper'

describe Address do
  context 'validations' do
    it {should allow_value("1715 I St. Sacramento, CA, 95811").for :address}
    it {should_not allow_value("A Street.").for :address}
    it {should validate_presence_of :address }
    it {should validate_presence_of :kind }
    it {should belong_to :contact}
  end

  context 'callbacks' do 
    it 'changes p and w into personal and work for kind.' do
      address = Address.new(:address => "8973 La Serena Dr., Fair Oaks, CA 95628", :kind => 'h')
      address.save
      address.kind.should eq 'home'
    end
  end
end