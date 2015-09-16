class RenameHashedPasswordToEncryptedPassword < ActiveRecord::Migration
  def self.up
  	rename_column :users, :hashed_password, :encrypted_password
  end

  def self.down
  	rename_column :users, :encrypted_password, :hashed_password
  end
end
