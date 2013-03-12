class Address < ActiveRecord::Base
  belongs_to :contact
  
  validates :address, :presence => true 
  validates :kind, :presence => true 
  validates :kind, :inclusion => {:in => %w(home work h w)}
  validates :address, :format => {:with => /\d+[\w\s.,]+\d{5}/,
                                   :message => "Not a valid address format"}
  
  before_save :kindify 

  def kindify
    if self.kind == 'w'
      self.kind = 'work' 
    elsif self.kind == 'h'
      self.kind = 'home'
    end
  end
end