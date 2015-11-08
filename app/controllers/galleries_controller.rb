class GalleriesController < ApplicationController
  
  def show
  end

  def create
    article = repo.article params[:article_id]
    repo.create_gallery article
    redirect_to article
  end

  def edit
    @form = repo.gallery_form params[:id]
    @form.images.build
  end

  def update
    @form = repo.gallery_form params[:id]
    repo.update_gallery @form, params[:gallery]
    if params[:gallery].nil?
      redirect_to gallery_path(@form.id)
    elsif params[:gallery][:image].map{|e| e.map{|k,v| v[:content]}}.flatten.compact.empty?
      redirect_to gallery_path(@form.id)
    else
      render :crop
    end
  end

end
