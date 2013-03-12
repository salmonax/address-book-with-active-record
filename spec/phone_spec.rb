require 'spec_helper'

describe Phone do
  context 'validations' do
    it {should allow_value("9169660701").for :phone }
    it {should_not allow_value("b98465465}").for :phone}
    it {should validate_presence_of :phone }
    it {should validate_presence_of :kind }
    it {should belong_to :contact}
  end

  context 'callbacks' do 
    it 'changes p and w into personal and work for kind' do
      phone = Phone.new(:phone => "9169660701", :kind => 'c')
      phone.save
      phone.kind.should eq 'cell'
    end
  end
end