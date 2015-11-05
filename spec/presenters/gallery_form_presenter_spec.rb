require 'active_support/core_ext/string/output_safety'
require './app/presenters/gallery_form_presenter'

describe GalleryFormPresenter do
  let(:object){ double :object }
  let(:builder){ double :builder }
  let(:template){ double :template }
  let(:presenter){ GalleryFormPresenter.new object, builder, template }

  subject{ presenter.send function }

  describe "#images" do
    let(:function){ :images }
    let(:image){ double :image }
    let(:image_id){ :id }
    let(:image_builder){ double :image_builder }
    let(:url){ nil }
    before do
      expect(object).to receive(:images){ [image] }
      expect(builder).to receive(:fields_for).
        with("image[][]",image,index:image_id ? image_id : 0).
        and_yield(image_builder)
      expect(image_builder).to receive(:label).with(:content, "Image 1").
        and_return("label")
      expect(image_builder).to receive(:file_field).with(:content).
        and_return("file_field")
      expect(image).to receive(:id){ image_id }
      expect(image).to receive(:content_url){ url }
    end

    context "new record" do
      it{ should eq "labelfile_field" }
    end

    context "with image" do
      let(:url){ :url }
      before{ expect(template).to receive(:image_tag).with(url){ "image" }}
      it{ should eq "imagelabelfile_field" }
    end

    context "old record" do
      let(:image_id){ nil }
      it{ should eq "labelfile_field" }
    end

  end
end
