class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment_owner , :polymorphic => true
end
