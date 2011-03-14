class Contact < ActiveRecord::Base
  contact_type=['Fax','GSM','Email','Fixe']
  belongs_to :contact_ref , :polymorphic => true
  validates :description ,:presence=>true
  validates :genre ,:presence=>true ,:inclusion => {:in =>contact_type  }
  validates :contact_data , :presence =>true


end
