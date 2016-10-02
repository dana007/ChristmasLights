class Picture < ActiveRecord::Base
    
    default_scope -> {order(created_at: :desc)}
    mount_uploader :image, PictureUploader
    
    
    
end
