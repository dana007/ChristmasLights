class User < ActiveRecord::Base
  has_many :favorites
  has_many :comments

  has_many :homes, through: :favorites
end
