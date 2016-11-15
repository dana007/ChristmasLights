class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :address
      t.integer :rating
      t.integer :user_id

      t.timestamps null: false
    end

    add_foreign_key :homes, :users
  end
end
