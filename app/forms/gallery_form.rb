class GalleryForm
  include ActiveModel::Model

  def initialize mdl
    @mdl = mdl
  end 

  def id; @mdl.id end
  def images; @mdl.images end

  #TODO error test, ex. gif, tif, jpg
  def update params
    update_images params[:images_attributes]
    @mdl.save
  end

  def persisted?; true end

  private
  
    #TODO 2 images
    def update_images params
      images.build params
    end

end
