class GalleryPresenter

  def initialize gallery, template
    @gallery = gallery
    @template = template
  end

  def images
    @gallery.images.reject(&:new_record?).map do |image|
      h.image_tag image.content_url(:thumb)
    end.join.html_safe
  end

  private

    def h; @template end 

end
