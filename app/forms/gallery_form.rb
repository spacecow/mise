class GalleryForm
  include ActiveModel::Model

  def initialize mdl
    @mdl = mdl
  end 

  def id; @mdl.id end
  def images; @mdl.images end

  #TODO error test, ex. gif, tif, jpg
  def update params
    update_images params[:images_attributes] || {}
    @mdl.save
  end

  def persisted?; true end

  private
  
    def update_images images_params
      images_params.each do |params|
        images.build params
      end
    end

end
