class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
    	t.string :name
    	t.string :company
    	t.text :description
    	t.datetime :released_at
    	t.integer :grade
    	t.string :platform

      t.timestamps
    end
  end
  def self.down
  	drop_table :games
  end
end
