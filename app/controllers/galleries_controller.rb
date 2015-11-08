class GalleriesController < ApplicationController
  
  def show
    @gallery = repo.gallery params[:id]
    @image = repo.build_image @gallery 
  end

  def create
    article = repo.article params[:article_id]
    gallery = repo.create_gallery article
    redirect_to gallery
  end

end
