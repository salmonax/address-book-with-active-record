require 'active_record'
require 'rspec'
require 'email'
require 'phone'
require 'address'
require 'contact'
require 'shoulda-matchers'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Email.all.each {|item| item.destroy}
    Address.all.each {|item| item.destroy}
    Phone.all.each {|item| item.destroy}
    Contact.all.each {|item| item.destroy}
 
  end
end