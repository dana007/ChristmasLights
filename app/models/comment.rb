class Comment < ActiveRecord::Base
  belongs_to :home
  belongs_to :user
end
