class Image < ActiveRecord::Base

  belongs_to :gallery

  mount_uploader :content, ImageUploader

end
