class ArticlePresenter

  def initialize article, template
    @article = article
    @template = template
  end

  def create_gallery_link
    h.link_to "Create Gallery", h.galleries_path(article_id:@article.id), method: :post
  end

  private

    def h; @template end 

end
