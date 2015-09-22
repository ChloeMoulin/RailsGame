class MakeProfileGeolocalisable < ActiveRecord::Migration
  def self.up
  	remove_column :profiles, :location_id
  	add_column :profiles, :address, :string
  	add_column :profiles, :latitude, :float
  	add_column :profiles, :longitude, :float
  end

  def self.down
  	add_column :profiles, :location_id, :integer
  	remove_column :profiles, :address
  	remove_column :profiles, :latitude
  	remove_column :profiles, :longitude
  end
end
