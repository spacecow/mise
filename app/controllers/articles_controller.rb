class ArticlesController < ApplicationController

  def show
    @article = repo.article params[:id]
    @image = repo.build_image @article.gallery 
  end

  def index
    @articles = repo.articles 
    @article = repo.new_article_form
  end

  def create
    @article = repo.new_article_form
    @article.save params.require(:article)
    redirect_to articles_path
  end

  def edit
    @article = repo.article params[:id] 
  end

  def update
    article = repo.article params[:id] 
    repo.update_article article, params.require(:article)
    redirect_to article
  end

end
