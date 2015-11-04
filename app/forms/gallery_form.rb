class GalleryForm
  include ActiveModel::Model

  def initialize mdl
    @mdl = mdl
  end 

  def id; @mdl.id end
  def images; @mdl.images end

  #TODO error test, ex. gif, tif, jpg
  def update params
    params ||= {}
    update_images params[:images_attributes].try(:first) || {}
    @mdl.save
  end

  def persisted?; true end

  private
  
    def update_images images_params
      images_params.each do |key, image_params|
        params = image_params.permit(:content)
        key == "0" ? images.build(params) : images.find(key).update(params)
      end
    end

end
