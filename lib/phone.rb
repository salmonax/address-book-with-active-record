class Phone < ActiveRecord::Base
  belongs_to :contact

  validates :phone, :presence => true
  validates :kind, :presence => true
  validates :kind, :inclusion => { :in => %w(home cell work h c w) }
  validates :phone, :format => {:with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/,
                                 :message => "Not a valid phone format"}
                                 
  before_save :kindify

  private 

  def kindify
    if self.kind == 'h'
      self.kind = 'home' 
    elsif self.kind == 'c'
      self.kind = 'cell'
    elsif self.kind == 'w'
      self.kind = 'work'
    end
  end

end

