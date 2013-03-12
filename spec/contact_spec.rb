describe Contact do 
  context 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :kind}
  end

  context 'associations' do
    it {should have_many(:emails)}
    it {should have_many(:phones)}
    it {should have_many(:addresses)}
  end
    # context 'callbacks' do
    #    it 'converts the name to title case' do
    #      contact = Contact.create(:first_name => "MIKE", :last_name => "PICCOLO")
    #      contact.first_name.should eq "Mike"
    #    end
    #  end
end