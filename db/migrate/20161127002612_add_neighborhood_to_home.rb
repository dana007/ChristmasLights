class AddNeighborhoodToHome < ActiveRecord::Migration
  def change
    add_column :homes, :neighborhood, :string
  end
end
