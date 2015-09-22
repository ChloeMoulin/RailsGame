class MakeTournamentGeolocalisable < ActiveRecord::Migration
  def self.up
  	remove_column :tournaments, :location_id
  	add_column :tournaments, :address, :string
  	add_column :tournaments, :latitude, :float
  	add_column :tournaments, :longitude, :float
  end

  def self.down
  	add_column :tournaments, :location_id, :integer
  	remove_column :tournaments, :address
  	remove_column :tournaments, :latitude
  	remove_column :tournaments, :longitude
  end
end
