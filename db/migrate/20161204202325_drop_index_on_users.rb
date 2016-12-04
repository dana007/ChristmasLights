class DropIndexOnUsers < ActiveRecord::Migration
  def change
    remove_index :comments, [:user_id, :home_id]
  end
end
