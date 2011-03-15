class Address < ActiveRecord::Base
  belongs_to :place , :polymorphic => true
  validates :street , :city , :country , :presence => true
  validates :street_number, :zip , :presence => true , :numericality => true
  
def address_to_string
  "#{street_number} , #{street} , #{zip} #{city} , #{country}"
end
end
#address.place => user_profile