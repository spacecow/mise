class GalleriesController < ApplicationController
  
  def create
    article = repo.article params[:article_id]
    repo.create_gallery article
    redirect_to article
  end

  def edit
    @gallery = repo.gallery_form params[:id]
    @gallery.images.build
  end

  def update
    form = repo.gallery_form params[:id]
    repo.update_gallery form, gallery_params
    redirect_to edit_gallery_path(form.id)
  end

  private

    def gallery_params 
      params.require(:gallery).permit(images_attributes: :content)
    end

end
