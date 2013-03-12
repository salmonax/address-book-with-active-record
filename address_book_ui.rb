require 'active_record'
require './lib/email'
require './lib/phone'
require './lib/address'
require './lib/contact'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuation = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuation)

def welcome
  puts "Welcome to the Epicodus Address App."
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' add a contact and 'l' to list contacts, view thier info and update thier info"
    choice = gets.chomp
    case choice
    when 'a'
      add_contact
    when 'l'
      list_contacts
    when 'e'
      exit
    else
      invalid
    end
  end
end

def add_contact
  contact = add_name 
  add_email(contact)
  add_phone(contact)
  add_address(contact)
end  

def add_name
  puts "What is your contacts first name?"
  first_name = gets.chomp
  puts "What is your contacts last name?"
  last_name = gets.chomp
  puts "What kind of contact is this? (Example: family)"
  contact_kind = gets.chomp
  contact = Contact.new(:first_name => first_name, :last_name => last_name, :kind => contact_kind)
  if contact.save   
    puts "#{first_name} #{last_name} has been added to your contacts.\n\n"
    contact
  else
    puts "Invalid contact. Here's what's wrong:"
    contact.errors.full_messages.each {|message| puts "   #{message}."}
    puts "\nPlease enter again.\n\n"
    add_name
  end
end

def add_email(contact)
  puts "Please enter in an email address:"
  email = gets.chomp
  puts "Press 'p' if this is a personal email address, 'w' if it is a work email address."
  email_kind = gets.chomp
  email_object = Email.new(:email => email, :contact_id => contact.id, :kind => email_kind)
  if email_object.save
    puts "Email address added."
  else
    puts "Invalid email. Here's what's wrong:"
    contact.errors.full_messages.each {|message| puts "   #{message}."}
    puts "\nPlease enter again.\n\n"
    add_email(contact)
  end
end

def add_phone(contact)
  puts "Please enter in a phone number:"
  phone_number = gets.chomp
  puts "Press 'h' if this is a home number, 'c' if it is a cell or 'w' if it is a work number."
  phone_kind = gets.chomp
  phone_object = Phone.new(:phone => phone_number, :contact_id => contact.id, :kind => phone_kind)
  if phone_object.save
    puts "Phone address added."
  else
    puts "Invalid phone. Please enter a valid phone number!"
    add_phone(contact)
  end
end

def add_address(contact)
  puts "Please enter in an address (Example: 1715 I St., Apt. R, Sacramento, CA, 95811): "
  address = gets.chomp
  puts "Press 'h' if this is a home address or 'w' if this is a work address."
  address_kind = gets.chomp
  address_object = Address.new(:address => address, :contact_id => contact.id, :kind => address_kind)
  if address_object.save
    puts "Address saved."
  else
    puts "Invalid address. Please enter a valid address!"
    add_address(contact)
  end
end

def list_contacts
  puts "Here is a list of your contacts:"
  Contact.all.each_with_index {|contact, i| puts "  #{i+1}. #{contact.first_name} #{contact.last_name}"}
  show_info
end

def show_info
  puts "Please pick a contact number to show their info."
  choice = gets.chomp.to_i
  contact = Contact.all[choice - 1]
  email = Email.find_by_contact_id(contact.id).email
  address = Address.find_by_contact_id(contact.id).address
  phone = Phone.find_by_contact_id(contact.id).phone
  puts " #{contact.first_name} #{contact.last_name}"
  puts "   E-mail:  #{email}"
  puts "   Phone:   #{phone}"
  puts "   Address: #{address}"
  puts "Would you like to edit this contact's info? (y/n)"
  choice = gets.chomp
  update_info(contact) unless choice.downcase != 'y'  
end

def update_info(contact)
  puts "1. #{contact.first_name} #{contact.last_name}"
  puts "2.   E-mail:  #{email}"
  puts "3.   Phone:   #{phone}"
  puts "4.   Address: #{address}"
  puts "Please enter the number you would like to edit. Actually, nevermind."

  # puts "Would you like to edit this contact's info? (y/n)"
  # choice = gets.chomp
  # update_info unless choice.downcase != 'y'  


end


def invalid
  puts "You suck."
end

def clear_database
  Email.all.each {|item| item.destroy}
  Address.all.each {|item| item.destroy}
  Phone.all.each {|item| item.destroy}
  Contact.all.each {|item| item.destroy}
end

def populate_db
  names = %w(Ray Bill Bob Mary Jennifer Jacobson McJacobs McMarty Martison)
  5.times do |x|
    contact = Contact.new(:first_name => names[rand(8)], :last_name => names[rand(8)], :kind => 'family')
    contact.save
    Email.create(:email => "mfp@lskdfj.com", :kind => 'p', :contact_id => contact.id)
    Phone.create(:phone => "9166665487", :kind => 'c', :contact_id => contact.id)
    Address.create(:address => "64645 psdflkjlfds 98797", :kind => 'h', :contact_id => contact.id)
  end
end

#clear_database
populate_db
welcome



