class ChangeTypeDatetimeToDateForGames < ActiveRecord::Migration
  def self.up
    change_column :games, :released_at, :date
  end

  def self.down
    change_column :games, :released_at, :datetime
  end
end
