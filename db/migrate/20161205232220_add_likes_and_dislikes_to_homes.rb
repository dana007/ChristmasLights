class AddLikesAndDislikesToHomes < ActiveRecord::Migration
  def change
    remove_column :homes, :rating, :integer
    add_column :homes, :likes, :integer, default: 0
    add_column :homes, :dislikes, :integer, default: 0
  end
end
