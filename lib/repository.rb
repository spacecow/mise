class Repository

  def article id; Article.find id end
 
  def gallery id; Gallery.find id end
  def gallery_form id; GalleryForm.new gallery(id) end
  def create_gallery article; article.create_gallery end
  def update_gallery gallery, params; gallery.update params end

end
