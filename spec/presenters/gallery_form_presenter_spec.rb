require 'active_support/core_ext/string/output_safety'
require './app/presenters/gallery_form_presenter'

describe GalleryFormPresenter do
  let(:object){ double :object }
  let(:builder){ double :builder }
  let(:presenter){ GalleryFormPresenter.new object, builder, :template }

  subject{ presenter.send function }

  describe "#images" do
    let(:function){ :images }
    let(:image){ double :image }
    let(:image_id){ :id }
    let(:image_builder){ double :image_builder }
    before do
      expect(object).to receive(:images){ [image] }
      expect(image).to receive(:id){ image_id }
      expect(builder).to receive(:fields_for).
        with("image[][]",image,index:image_id ? image_id : 0).
        and_yield(image_builder)
      expect(image_builder).to receive(:label).with(:content, "Image 1").
        and_return("label")
      expect(image_builder).to receive(:file_field).with(:content).
        and_return("file_field")
    end

    context "new record" do
      it{ subject }
    end

    context "old record" do
      let(:image_id){ nil }
      it{ subject }
    end

  end
end
