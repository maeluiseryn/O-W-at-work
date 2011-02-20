class UserProfile < ActiveRecord::Base
belongs_to :user
has_one  :address , :as => :place


end
