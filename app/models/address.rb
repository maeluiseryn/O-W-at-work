class Address < ActiveRecord::Base
  belongs_to :place , :polymorphic => true
  validates :description ,:street , :city  , :presence => true
  validates :street_number, :zip , :presence => true , :numericality => true
define_index do
  set_property :enable_star => 1
  set_property :min_infix_len => 3
  indexes description
  indexes street
  indexes zip
  indexes city
  has created_at ,updated_at
end
def address_to_string
  "#{street_number} #{street} #{zip} #{city} #{country}"
end
def address_to_mappy_string
  "#{city},+#{zip},+#{street},+#{street_number},+#{country}"
end
def format_url_for_google_maps
  "http://maps.google.com/?q=#{address_to_string}"
end
def format_url_for_mappy_maps
  "http://fr.mappy.com/map#d=#{address_to_mappy_string}"
end
def format_url_for_mappy_itinerary source_address_mappy_string #not proper place because it accept data from another address instance
  "http://fr.mappy.com/itinerary#d[]=#{source_address_mappy_string}&d[]=#{address_to_mappy_string}"
end
end
#address.place => user_profile