class Comment < ActiveRecord::Base

  include AASM
  attr_accessor :message_box_id
  belongs_to :user
  belongs_to :comment_owner , :polymorphic => true
  has_many :contacts , :as=>:contact_ref
  accepts_nested_attributes_for :contacts ,:reject_if => lambda { |a| a[:description].blank? && a[:contact_data].blank? } ,:allow_destroy => true
  aasm_column :comment_state # defaults to aasm_state

    aasm_initial_state :unread

    aasm_state :unread 
    aasm_state :read
    aasm_state :archive
    aasm_state :mark_for_delete


    aasm_event :has_been_read do
      transitions :to => :read, :from => [:unread]
    end
    aasm_event :has_been_archived do
      transitions :to => :archive , :from =>[:read]
    end
    aasm_event :to_trash do
      transitions :to => :mark_for_delete, :from => [:read, :archive]
    end
end
