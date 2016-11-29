class ChangeRatingDefaultOnHomes < ActiveRecord::Migration
  def up
    change_column :homes, :rating, :integer, :default => 0
    Home.find_each do |home|
      home.rating = 0
      home.save!
    end
  end

  def down
  end
end
