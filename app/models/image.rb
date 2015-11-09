class Image < ActiveRecord::Base

  belongs_to :gallery

  mount_uploader :content, ImageUploader

  def article; gallery.article end

end
