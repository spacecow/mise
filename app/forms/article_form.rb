class ArticleForm
  include ActiveModel::Model

  attr_accessor :article, :title

  def initialize article
    self.article = article
    self.title = article.title
  end

  def id; article.id end
  def gallery; article.gallery end
  def errors; article.errors end

  def save params
    begin
      article.update params.permit(:title)
      article.create_gallery
      true
    rescue ActiveRecord::StatementInvalid => e
      article.errors.add(:title,"can't be blank")
      false
    end
  end

  def update params
    article.update params.permit(:title)
    true
  end

  def persisted?; article.new_record? ? false : true end

end
