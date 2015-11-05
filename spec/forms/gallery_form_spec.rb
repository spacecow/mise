module ActiveModel
  module Model; end
end
require './app/forms/gallery_form'
require 'active_support/core_ext/object/try'
require 'action_controller'

describe GalleryForm do

  let(:gallery){ double :gallery }
  let(:form){ GalleryForm.new gallery }

  subject{ form.send function, params }

  describe "#update" do
    let(:function){ :update }
    before do
      expect(form).to receive(:update_images).with({})
      expect(gallery).to receive(:save)
    end

    context "params is nil" do
      let(:params){ nil }
      it("sends a hash to update_images"){ subject }
    end

    context "params does not include image" do
      let(:params){{ xxx: :xxx }}
      it("sends a hash to update_images"){ subject }
    end
  end

  describe "#update_images" do
    let(:function){ :update_images }

    context "params is empty" do
      let(:params){ {} }
      it{ subject }
    end

    context "params include a new entry" do
      let(:params){ ActionController::Parameters.new({"0":{content: :content}}) }
      let(:images){ double :images }
      before do
        expect(form).to receive(:images){ images }
        expect(images).to receive(:build).with(content: :content)
      end
      it{ subject }
    end

    context "params include an old entry" do
      let(:params){ ActionController::Parameters.new({"666":{content: :content}}) }
      let(:images){ double :images }
      let(:image){ double :image }
      before do
        expect(form).to receive(:images){ images }
        expect(images).to receive(:find).with("666"){ image }
        expect(image).to receive(:update).with(content: :content)
      end
      it{ subject }
    end

  end

  #context "change first image" do
  #  it "" do
  #    attach_file "Image 1", './spec/images/flower2.gif'
  #    click_button "Update Gallery"
  #    image = Image.last
  #    expect(Image.count).to be 1
  #    expect(image.content_identifier).to eq "flower2.gif"
  #    expect(image.gallery_id).to be Gallery.last.id
  #  end
  #end

  #context "add first image" do
  #  let(:image){ nil }
  #  it "" do
  #    attach_file "Image 1", './spec/images/flower.gif'
  #    click_button "Update Gallery"
  #    image = Image.last
  #    expect(Image.count).to be 1
  #    expect(image.content_identifier).to eq "flower.gif"
  #    expect(image.gallery_id).to be Gallery.last.id
  #  end
  #end
end

