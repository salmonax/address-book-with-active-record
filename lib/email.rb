class Email < ActiveRecord::Base
  belongs_to :contact

  validates :email, :presence => true
  validates :kind, :presence => true
  validates :kind, :inclusion => { :in => %w(personal work w p) }
  validates :email, :format => { :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/,
                                 :message => "Not a valid email format." }
  
  before_save :kindify 

private 

  def kindify
    if self.kind == 'p'
      self.kind = 'personal' 
    elsif self.kind == 'w'
      self.kind = 'work'
    end
  end

end