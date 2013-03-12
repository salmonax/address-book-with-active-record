require 'spec_helper'

describe Email do
  context 'validations' do
    it {should allow_value("mfpiccolo@gmail.com").for :email }
    it {should_not allow_value("reale$$$$mail@something.com").for :email}
    it {should validate_presence_of :email }
    it {should validate_presence_of :kind }
    it {should ensure_inclusion_of(:kind).in_array(['personal','work'])}
  end

  context 'associations' do
    it {should belong_to :contact}
  end

  context 'callbacks' do 
    it 'changes p and w into personal and work for kind.' do
      email = Email.new(:email => "mfp@lskdfj.com", :kind => 'p')
      email.save
      email.kind.should eq 'personal'
    end
  end
end