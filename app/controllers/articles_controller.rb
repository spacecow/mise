class ArticlesController < ApplicationController

  def show
    @article = repo.article params[:id]
  end

end
