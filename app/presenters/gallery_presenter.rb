class GalleryPresenter < BasePresenter
  presents :gallery

  def images
    gallery.images.reject(&:new_record?).map do |image|
      h.link_to h.image_tag(image.content_url(:thumb)), image.content_url
    end.join.html_safe
  end

end
