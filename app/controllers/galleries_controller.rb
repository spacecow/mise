class GalleriesController < ApplicationController
  
  def create
    article = repo.article params[:article_id]
    repo.create_gallery article
    redirect_to article
  end

end
