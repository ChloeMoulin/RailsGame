class AddLocationIdTournament < ActiveRecord::Migration
  def self.up
  	add_column :tournaments, :location_id, :integer
  end

  def self.down
  	remove_column :tournaments, :location_id
  end
end
