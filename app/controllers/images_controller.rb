class ImagesController < ApplicationController

  def create
    image = repo.create_image params[:image]
    redirect_to image.gallery
  end

end