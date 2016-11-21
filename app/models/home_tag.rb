class HomeTag < ActiveRecord::Base
  belongs_to :home
  belongs_to :tag
end
