class UpdateHomeAddress < ActiveRecord::Migration
  def change
    remove_column :homes, :address, :string
    add_column :homes, :street_address, :string
    add_column :homes, :city, :string
    add_column :homes, :state, :string
    add_column :homes, :zip_code, :string
  end
end
