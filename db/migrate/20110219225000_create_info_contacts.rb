class CreateInfoContacts < ActiveRecord::Migration
  def self.up
    create_table :info_contacts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :info_contacts
  end
end
