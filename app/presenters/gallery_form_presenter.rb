class GalleryFormPresenter

  def initialize object, builder, template
    @object = object
    @builder = builder
    @template = template
  end

  def images
    @object.images.each_with_index.map do |image,i|
      @builder.fields_for "image[][]", image, index:image.id || 0 do |image_builder|
        image_builder.label(:content, "Image #{i+1}") +
        image_builder.file_field(:content)
      end
    end.join.html_safe
  end

end
