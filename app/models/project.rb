class Project < ActiveRecord::Base
PROJECT_TYPE=['Projet standard' ,'Fourniture', 'Reparation' , 'Assurance']
before_create :create_ref
include AASM

belongs_to :client

has_one  :address ,  :as => :place

has_many :user_projects
has_many :users, :through => :user_projects
has_many :project_components
has_many :contacts , :as=> :contact_ref
has_one :message_box ,:as =>:box_owner
has_many :uploaded_files , :as=>:file_owner
has_many :invoices
accepts_nested_attributes_for :contacts ,:reject_if => lambda { |a| a[:description].blank? && a[:contact_data].blank? } ,:allow_destroy => true
accepts_nested_attributes_for :address ,:project_components

define_index do
      set_property :enable_star => 1
      set_property :min_infix_len => 3
      indexes client_id
      indexes project_ref
      indexes client.surname , :as => :client_surname
      indexes client.name ,:as=>:client_name
      has  created_at, updated_at , project_state
end
aasm_column :project_state # defaults to aasm_state

    aasm_initial_state :created

    aasm_state :created ,:exit=> :message_box_create
    aasm_state :active
    aasm_state :offer
    aasm_state :waiting_payment # not sure
    aasm_state :production
    aasm_state :closed
    aasm_state :waiting
    aasm_state :archive
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
  def send_fiche_de_rendez_vous
     Document.fiche_de_rendez_vous(self).deliver
  end
  def send_sav_form
     Document.SAV_form(self).deliver
  end
  def self.get_project_type
    PROJECT_TYPE
  end
  def project_ref_string
    "C#{client_id}P#{project_ref}"
  end
  def message_box_create
   build_message_box(:description =>self.project_ref_string+" "+client.surname.capitalize)
   message_box.save
  end
end
