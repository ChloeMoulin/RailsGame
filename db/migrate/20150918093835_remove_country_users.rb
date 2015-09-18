class RemoveCountryUsers < ActiveRecord::Migration
  def self.up
  	remove_column :profiles, :country
  end

  def self.down
  	add_column :profiles, :country, :string
  end
end
