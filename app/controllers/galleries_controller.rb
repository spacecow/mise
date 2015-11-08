class GalleriesController < ApplicationController
  
  def show
  end

  def create
    article = repo.article params[:article_id]
    gallery = repo.create_gallery article
    redirect_to gallery
  end

end
