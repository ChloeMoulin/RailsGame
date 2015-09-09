class AddColumnsNameAndDescriptionToTournaments < ActiveRecord::Migration
  def self.up
  	add_column :tournaments, :name, :string
  	add_column :tournaments, :description, :text
  end
  def self.down
  	remove_column :tournaments, :name
  	remove_column :tournaments, :description
  end
end
