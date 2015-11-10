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
    if @article.save params.require(:article)
      redirect_to articles_path
    else
      @articles = repo.articles 
      render :index
    end
  end

  def edit
    @article = repo.article_form params[:id]
  end

  def update
    @article = repo.article_form params[:id]
    if @article.update params.require(:article)
      redirect_to @article
    end
  end

end
