class RenameCoverUser < ActiveRecord::Migration
  def up
    rename_column :games, :cover_filename, :cover
  end

  def down
  end
end
