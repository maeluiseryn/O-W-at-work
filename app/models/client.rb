class Client < ActiveRecord::Base
has_many :projects
has_many  :addresses , :as => :place
has_many :projects_addresses, :through => :projects, :source => :addresses
end
