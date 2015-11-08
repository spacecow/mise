class Image < ActiveRecord::Base

  belongs_to :gallery

  mount_uploader :content, ImageUploader  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

end
