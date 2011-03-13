class UserProject < ActiveRecord::Base
belongs_to :user
belongs_to :project
validates :name , :surname , :presence=>true
end
