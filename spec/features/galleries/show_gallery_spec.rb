require 'rails_helper'

describe "Show gallery" do

  let(:gallery){ create :gallery }
  let(:image){ nil }

  before do
    image
    visit gallery_path(gallery)
  end

  context "image already uploaded" do
    let(:image){ create :image, gallery: gallery }
    it "" do
      expect(page).to have_selector "img"
    end
  end

  it "create gallery" do
    expect(page).not_to have_selector "img"
    attach_file "Image", './spec/images/flower.gif'
    click_button "Add Image"
    image = Image.last
    expect(Image.count).to be 1
    expect(image.gallery_id).to be gallery.id
    expect(image.content_identifier).to eq "flower.gif" 
    expect(current_path).to eq gallery_path(gallery)
  end

end
