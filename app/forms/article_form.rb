class ArticleForm
  include ActiveModel::Model

  attr_accessor :article

  def initialize article
    self.article = article
  end

  def id; article.id end
  def gallery; article.gallery end
  def errors; article.errors end
  def title; article.title end

  def save params
    begin
      article.update params.permit(:title)
      article.create_gallery
      true
    rescue ActiveRecord::StatementInvalid
      article.errors.add(:title,"can't be blank")
      false
    end
  end

  def update params
    begin
      article.update params.permit(:title)
      true
    rescue ActiveRecord::StatementInvalid
      article.errors.add(:title,"can't be blank")
      false
    end
  end

  def persisted?; article.new_record? ? false : true end

end
