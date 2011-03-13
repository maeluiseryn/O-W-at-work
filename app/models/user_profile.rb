class UserProfile < ActiveRecord::Base
belongs_to :user
has_one  :address , :as => :place
has_many :contacts , :as => :contact_ref

end
