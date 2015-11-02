class Image < ActiveRecord::Base

  mount_uploader :content, ImageUploader  

end
