class Post < ActiveRecord::Base
    belongs_to :picture
    default_scope -> {order(created_at: :desc)}
    mount_uploader :picture, PictureUploader
    
end
