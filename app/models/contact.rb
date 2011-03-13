class Contact < ActiveRecord::Base
  belongs_to :contact_ref , :polymorphic => true
  validates :description ,:presence=>true
  validates :genre ,:presence=>true ,:inclusion => {:in => ['Fax','GSM','Email','Fixe'] }
  validates :contact_data , :presence =>true


end
