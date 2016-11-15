class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :home_id

      t.timestamps null: false
    end

    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :homes
    add_index :favorites, [:user_id, :home_id], :unique => true
  end
end
