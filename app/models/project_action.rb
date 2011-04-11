class ProjectAction < ActiveRecord::Base
  include AASM
   ACTION_TYPE=["Rendez-vous","Offre de Prix","Emission de Facture",""]
   belongs_to :user
   belongs_to :project
   aasm_column :action_state # defaults to aasm_state

       aasm_initial_state :open

       aasm_state :open
       aasm_state :success
       aasm_state :failure



       aasm_event :succeed do
         transitions :to => :success, :from => [:open]
       end

       aasm_event :failed do
         transitions :to => :failure , :from => [:open]
       end

end
