class Project < ActiveRecord::Base
include AASM
belongs_to :client
has_many :user_projects
has_many :users, :through => :user_projects
has_many :project_components
has_one  :address , :as => :place

aasm_column :project_state # defaults to aasm_state

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


end
