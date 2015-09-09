class CreateGamesTournaments < ActiveRecord::Migration
  def self.up
  	create_table :games_tournaments, :id => false do |t|
  		t.references :game
  		t.references :tournament
  	end
  end

  def self.down
  	drop_table :games_tournaments
  end
end
