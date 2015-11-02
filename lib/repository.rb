class Repository

  def article id; Article.find id end
 
  def create_gallery article; article.create_gallery end

end
