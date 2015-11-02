class GalleriesController < ApplicationController
  
  def create
    article = repo.article params[:article_id]
    repo.create_gallery article
    redirect_to article
  end

  def edit
    @gallery = Gallery.find params[:id]
    @gallery.images.build
  end

  def update
    gallery = Gallery.find params[:id]
    gallery.update params.require(:gallery).permit(image_attributes: :content)
    redirect_to edit_gallery_path(gallery)
  end

end
