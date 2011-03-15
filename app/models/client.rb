class Client < ActiveRecord::Base
has_many :projects
has_many :addresses , :as => :place
has_many :projects_addresses, :through => :projects, :source => :addresses
has_many :contacts , :as => :contact_ref

validates :name , :surname , :presence => true

def has_projects?
     if self.projects.empty?
       return false
     else
       return true
     end
  end
 def has_addresses?
     if self.addresses.empty?
       return false
     else
       return true
     end
 end
 def has_contacts?
     if self.contacts.empty?
       return false
     else
       return true
     end
 end
end
