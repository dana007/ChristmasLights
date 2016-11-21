class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :tag_type_id
      t.integer :value

      t.timestamps null: false
    end

    add_foreign_key :tags, :tag_types
  end
end
