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
    update_images images_params(params) 
    @mdl.save
  end

  def persisted?; true end

  private
  
    def update_images images_params
      images_params.each do |params|
        images.build params.values[0].permit(:content)
      end
    end

    def images_params params
      return {} if params[:images_attributes].nil?
      [Hash[params[:images_attributes].map{|h| [0,h]}]]
    end

end
