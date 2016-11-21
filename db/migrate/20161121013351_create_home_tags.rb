class CreateHomeTags < ActiveRecord::Migration
  def change
    create_table :home_tags do |t|
      t.integer :home_id
      t.integer :tag_id

      t.timestamps null: false
    end

    add_foreign_key :home_tags, :homes
    add_foreign_key :home_tags, :tags
  end
end
