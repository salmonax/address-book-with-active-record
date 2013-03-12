class Contact < ActiveRecord::Base
  has_many :emails
  has_many :phones
  has_many :addresses

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :kind, :presence => true

 
  # before_save :capitalize_name

  private

  def capitalize_name
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end
end