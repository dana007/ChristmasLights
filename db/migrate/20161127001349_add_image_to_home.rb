class AddImageToHome < ActiveRecord::Migration
  def change
    add_attachment :homes, :image
  end
end
