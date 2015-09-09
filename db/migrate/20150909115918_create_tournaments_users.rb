class CreateTournamentsUsers < ActiveRecord::Migration
  def self.up
  	create_table :users_tournaments, :id => false do |t|
  		t.references :user
  		t.references :tournament
  	end
  end

  def self.down
  	drop_table :users_tournaments
  end
end
