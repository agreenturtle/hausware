class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  
  validates :space, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
  attr_accessor :save_details_for_next_time
  
  after_save :save_details_for_next_time_to_user
  
  # Only overwrites phone & zipcode, and imports email if not previously saved to user
  def save_details_for_next_time_to_user
    return true unless self.user # require a user to save to next time
    
    details = {}
    details[:email] = self.email if self.user.email.blank?
    details[:phone] = self.phone
    details[:zipcode] = self.zipcode
    
    self.user.update_attributes(details)
    true # Keep filter chain going even if it couldn't save details
  end
end