class Repository

  def article id; Article.find id end
 
  def gallery id; Gallery.find id end
  def create_gallery article; article.create_gallery end

  def build_image gallery; gallery.images.build end

  def create_image params
    gallery = gallery params.delete(:gallery_id)
    gallery.images.create params 
  end 

end
