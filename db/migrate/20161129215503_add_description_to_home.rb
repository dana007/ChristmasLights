class AddDescriptionToHome < ActiveRecord::Migration
  def change
    add_column :homes, :description, :string
  end
end
