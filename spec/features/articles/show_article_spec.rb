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

  #TODO create empty image generates error
  it "create image" do
    expect(page).not_to have_selector "img"
    attach_file "Image", './spec/images/flower.gif'
    click_button "Add Image"
    image = Image.last
    expect(Image.count).to be 1
    expect(image.gallery_id).to be gallery.id
    expect(image.content_identifier).to eq "flower.gif" 
    expect(current_path).to eq article_path(gallery.article)
  end

end
