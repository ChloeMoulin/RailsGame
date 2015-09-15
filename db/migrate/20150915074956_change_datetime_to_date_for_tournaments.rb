class ChangeDatetimeToDateForTournaments < ActiveRecord::Migration
  def self.up
    change_column :tournaments, :date, :date
  end

  def self.down
    change_column :tournaments, :date, :datetime
  end
end
