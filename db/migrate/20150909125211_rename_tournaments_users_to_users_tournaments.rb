class RenameTournamentsUsersToUsersTournaments < ActiveRecord::Migration
  def self.up
  	rename_table :users_tournaments, :tournaments_users
  end

  def self.down
  	ename_table :tournaments_users, :users_tournaments
  end
end
