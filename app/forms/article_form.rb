class ArticleForm
  include ActiveModel::Model

  attr_accessor :article, :title

  def initialize article
    self.article = article
  end

  def save params
    article.update params.permit(:title)
    article.create_gallery
  end

  def update params
    article.update params.permit(:title)
  end

  def id; article.id end
  def persisted?; article.new_record? ? false : true end

end
