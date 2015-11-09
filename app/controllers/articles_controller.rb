class ArticlesController < ApplicationController

  def show
    @article = repo.article params[:id]
  end

  def index
    @articles = Article.all
    @article = repo.new_article
  end

  def create
    repo.create_article params.require(:article)
    redirect_to articles_path
  end

  def edit
  end

end
