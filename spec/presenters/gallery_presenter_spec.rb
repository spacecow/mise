require 'active_support/core_ext/string/output_safety'
require './app/presenters/gallery_presenter'

describe GalleryPresenter do

  let(:presenter){ GalleryPresenter.new gallery, view }
  let(:gallery){ double :gallery }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#images" do
    let(:function){ :images }
    let(:image){ double :image }
    let(:new_record){ true }
    before do
      expect(gallery).to receive(:images).with(no_args){ [image] }
      expect(image).to receive(:new_record?).with(no_args){ new_record }
    end

    context "Has no saved images" do
      it{ should be_blank }
    end

    context "Has saved image" do
      let(:new_record){ false }
      before do
        expect(view).to receive(:image_tag).with(:url){ "image" }
        expect(image).to receive(:content_url).with(:thumb){ :url }
      end
      it{ should eq "image" }
    end

  end
end
