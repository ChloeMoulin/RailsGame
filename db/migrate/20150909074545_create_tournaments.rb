class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
    	t.string :place
    	t.datetime :date
    	t.integer :max_player


      	t.timestamps
    end
  end

  def self.down
  	drop_table :tournaments
  end
end
