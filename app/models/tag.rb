class Tag < ActiveRecord::Base
  has_many :homes, through: :home_tags
end
