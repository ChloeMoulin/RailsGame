class RemoveColumnPlaceTournament < ActiveRecord::Migration
  def self.up
  	remove_column :tournaments, :place
  end

  def self.down
  	add_column :tournaments, :place, :string
  end
end
