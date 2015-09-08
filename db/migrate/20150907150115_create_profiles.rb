class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :country
      t.integer :age
      t.integer :score
      t.integer :victories
      t.integer :defeats
      t.integer :score
      t.float :ratio

      t.timestamps
    end
  end
end
