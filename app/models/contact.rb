class Contact < ActiveRecord::Base
  CONTACT_TYPE=['Fax','GSM','Email','Fixe']

  belongs_to :contact_ref , :polymorphic => true

  validates :description ,:presence=>true
  validates :genre ,:presence=>true ,:inclusion => {:in =>CONTACT_TYPE  }
  validates :contact_data , :presence =>true

  define_index do
      set_property :enable_star => 1
      set_property :min_infix_len => 3
      indexes description
      indexes contact_data
      has  created_at, updated_at , genre
  end

def get_contact_type
  CONTACT_TYPE
end
def self.get_contact_type
  CONTACT_TYPE
end
end
