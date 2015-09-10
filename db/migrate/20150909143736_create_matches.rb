class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
    	t.integer :player_1_id
    	t.integer :player_2_id
    	t.integer :player_1_score
    	t.integer :player_2_score
    	t.integer :player_1_points
    	t.integer :player_2_points

      t.timestamps
    end
  end
  def self.down
  	drop_table :matches
  end
end
