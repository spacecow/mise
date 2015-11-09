require 'rails_helper'

describe "Show article" do

  let(:article){ create :article }
  let(:gallery){ create :gallery, article:article }
  let(:image){ nil }

  before do
    image
    gallery
    visit article_path(article)
  end

  context "image already uploaded" do
    let(:image){ create :image, gallery: gallery }
    it "" do
      expect(page).to have_selector "img"
    end
  end

  it "create image" do
    expect(page).not_to have_selector "img"
    attach_file "Image", './spec/images/flower.gif'
    click_button "Add Image"
    image = Image.last
    expect(Image.count).to be 1
    expect(image.gallery_id).to be gallery.id
    expect(image.content_identifier).to eq "flower.gif" 
    expect(current_path).to eq gallery_path(gallery)
  end

  #context "create gallery" do
  #  let(:gallery){ nil }
  #  it "" do
  #    click_link "Create Gallery"
  #    gallery = Gallery.last
  #    expect(Gallery.count).to be 1
  #    expect(gallery.article_id).to be article.id
  #    expect(current_path).to eq gallery_path(gallery)
  #  end
  #end

end
