class Contact < ActiveRecord::Base
  CONTACT_TYPE=['Fax','GSM','Email','Fixe']
  belongs_to :contact_ref , :polymorphic => true
  validates :description ,:presence=>true
  validates :genre ,:presence=>true ,:inclusion => {:in =>CONTACT_TYPE  }
  validates :contact_data , :presence =>true
def get_contact_type
  CONTACT_TYPE
end
def self.get_contact_type
  CONTACT_TYPE
end
end
