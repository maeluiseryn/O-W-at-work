class AddEmailEncryptPasswordToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :users, :encrypted_password, :string
  end

  def self.down
    remove_column :users, :encrypted_password
    remove_column :users, :email
  end
end
