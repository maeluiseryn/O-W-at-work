class UserProfile < ActiveRecord::Base


  belongs_to :user
has_one  :address , :as => :place
has_many :contacts , :as => :contact_ref
accepts_nested_attributes_for :contacts , :allow_destroy => true

accepts_nested_attributes_for :address

#nested forms fields_for
# jquery dynamic form ryanb github complex forms exemple
#Working .contacts_attributes=[ { :genre => 'Fax' ,:description=>'tel2',:contact_data=>'02020202'}, {:description=>'tel', :genre => 'Fax',:contact_data=>'02020202' } ]
end
