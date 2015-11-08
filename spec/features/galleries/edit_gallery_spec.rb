require 'rails_helper'

describe "edit gallery" do

  let(:gallery){ create :gallery }
  let(:image){ create :image, gallery:gallery,
    content:File.open('./spec/images/flower.gif'),
    crop_x:666 }

  before do
    image
    visit edit_gallery_path(gallery)
  end

  pending "add two images with javascript"

  #TODO leave one image alone
  context "add a second image, change the first" do
    it "" do
      expect(page).to have_selector("img", count:1)     
      attach_file "Image 1", './spec/images/flower2.gif'
      attach_file "Image 2", './spec/images/flower.gif'
      click_button "Update Gallery"
      first_image = Image.first
      last_image = Image.last
      expect(Image.count).to be 2
      expect(first_image.content_identifier).to eq "flower2.gif"
      expect(first_image.gallery_id).to be Gallery.last.id
      expect(last_image.content_identifier).to eq "flower.gif"
      expect(last_image.gallery_id).to be Gallery.last.id
      click_button "Crop"
    end
  end

  context "update empty gallery" do
    let(:image){ nil }
    it "" do
      click_button "Update Gallery"
      expect(Image.count).to be 0
      expect(page).to_not have_button "Crop"
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

  #context "resubmit first image" do
  #  it "" do
  #    click_button "Update Gallery"
  #    image = Image.last
  #    expect(Image.count).to be 1
  #    expect(image.content_identifier).to eq "flower.gif"
  #    expect(image.gallery_id).to be Gallery.last.id
  #  end
  #end

  #context "add a second image" do
  #  it "" do
  #    attach_file "Image 2", './spec/images/flower2.gif'
  #    click_button "Update Gallery"
  #    image = Image.last
  #    expect(Image.count).to be 2
  #    expect(image.content_identifier).to eq "flower2.gif"
  #    expect(image.gallery_id).to be Gallery.last.id
  #  end
  #end

end
