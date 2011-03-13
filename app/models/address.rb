class Address < ActiveRecord::Base
  belongs_to :place , :polymorphic => true
  validates :street , :city , :country , :presence => true
  validates :street_number, :zip , :presence => true , :numericality => true
  
end
