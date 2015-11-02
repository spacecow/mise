class Gallery < ActiveRecord::Base

  belongs_to :article
  has_many :images

  #TODO 2 images
  def image_attributes= attrs
    images.build attrs
  end
end
