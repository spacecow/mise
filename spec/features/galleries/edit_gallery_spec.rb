require 'rails_helper'

describe "edit gallery" do

  let(:gallery){ create :gallery }
  let(:image){ create :image, gallery:gallery,
    content:File.open('./spec/images/flower.gif') }

  before do
    image
    visit edit_gallery_path(gallery)
  end

  pending "no image, empty gallery"

  pending "change first image"

  context "add first image" do
    let(:image){ nil }
    it "" do
      attach_file "Image 1", './spec/images/flower.gif'
      click_button "Update Gallery"
      image = Image.last
      expect(image.content_identifier).to eq "flower.gif"
      expect(image.gallery_id).to be Gallery.last.id
    end
  end

  context "resubmit first image" do
    it "" do
      click_button "Update Gallery"
      image = Image.last
      expect(image.content_identifier).to eq "flower.gif"
      expect(image.gallery_id).to be Gallery.last.id
    end
  end

  #context "add a second image" do
  #  it "" do
  #    attach_file "Image 2", './spec/images/flower.gif'
  #    click_button "Update Gallery"
  #    image = Image.last
  #    expect(image.content_identifier).to eq "flower.gif"
  #    expect(image.gallery_id).to be Gallery.last.id
  #  end
  #end

end
