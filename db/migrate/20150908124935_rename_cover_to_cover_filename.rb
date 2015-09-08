class RenameCoverToCoverFilename < ActiveRecord::Migration
  def self.up
  	rename_column :games, :cover, :cover_filename
  end

  def down
  	rename_column :games, :cover_filename, :cover
  end
end
