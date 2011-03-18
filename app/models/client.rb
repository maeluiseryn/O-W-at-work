class Client < ActiveRecord::Base
include AASM
has_many :projects
has_many :addresses , :as => :place
has_many :projects_addresses, :through => :projects, :source => :addresses
has_many :contacts , :as => :contact_ref
has_many :user_clients , :dependent => :destroy
has_many :users ,:through => :user_clients
validates :name , :surname , :presence => true
aasm_column :client_state # defaults to aasm_state

    aasm_initial_state :created

    aasm_state :created
    aasm_state :active
    aasm_state :waiting
    aasm_state :dead


    aasm_event :activated do
      transitions :to => :active, :from => [:created]
    end

    aasm_event :closed do
      transitions :to => :dead, :from => [:active, :waiting]
    end

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
