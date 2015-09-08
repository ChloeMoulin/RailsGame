class AddCoverImageForGames < ActiveRecord::Migration
  def up
  	add_column :games, :cover, :string
  end

  def down
  	remove_column :games, :cover
  end
end
