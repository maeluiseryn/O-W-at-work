class Project < ActiveRecord::Base
belongs_to :client
has_many :user_projects
has_many :users, :through => :user_projects
has_many  :addresses , :as => :place

end
