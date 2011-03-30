class Project < ActiveRecord::Base
before_create :create_ref
include AASM
belongs_to :client
has_many :user_projects
has_many :users, :through => :user_projects
has_many :project_components
has_one  :address ,  :as => :place
has_many :contacts , :as=> :contact_ref
has_many :comments , :as=> :comment_owner
has_many :uploaded_files , :as=>:file_owner
accepts_nested_attributes_for :contacts ,:reject_if => lambda { |a| a[:description].blank? && a[:contact_data].blank? } ,:allow_destroy => true
accepts_nested_attributes_for :address ,:project_components
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
    def create_home_directory(public_path)
    self.home_directory=File.join("#{self.client.home_directory}/","p#{self.project_ref.to_s}")
    ServerFileOperation.create_directory({:path=>"#{self.client.home_directory}",:name=>"p#{self.project_ref.to_s}"},public_path)

  end
  def self.create_home_directory(home_directory,public_path)
    ServerFileOperation.create_directory(home_directory,public_path)
  end
  def create_ref
     ref_number=Client.find(self.client_id).projects.count
     self.project_ref=ref_number+1
  end
end
