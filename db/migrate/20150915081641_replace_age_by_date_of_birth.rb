class ReplaceAgeByDateOfBirth < ActiveRecord::Migration
  def self.up
    remove_column :profiles, :age
    add_column :profiles, :date_of_birth, :date
  end

  def self.down
    remove_column :profiles, :date_of_birth
    add_column :profiles, :age, :integer
  end
end
