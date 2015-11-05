class GalleryForm
  include ActiveModel::Model

  def initialize gallery
    @gallery = gallery
  end 

  def id; @gallery.id end
  def images; @gallery.images end

  #TODO error test, ex. gif, tif, jpg
  def update params
    params ||= {}
    update_images params[:image].try(:first) || {}
    @gallery.save
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
