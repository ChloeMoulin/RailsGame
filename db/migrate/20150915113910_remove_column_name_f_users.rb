class RemoveColumnNameFUsers < ActiveRecord::Migration
  def self.up
  	remove_column :users, :name_f
  end

  def self.down
  	add_column :users, :name_f, :string
  end
end
