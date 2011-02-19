class User < ActiveRecord::Base
has_one :user_profile
has_many :user_projects
has_many :projects, :through => :user_projects

end
