class Recontact < ActiveRecord::Migration

    def self.up
      create_table :contacts do |t|
        t.string :description
        t.string :genre
        t.string :contact_data
        t.references :contact_ref, :polymorphic => true
        t.timestamps
      end
    end

    def self.down
      drop_table :contacts
    end
  end


