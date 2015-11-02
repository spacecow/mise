require 'rails_helper'

describe "edit gallery" do

  let(:gallery){ create :gallery }

  before do
    visit edit_gallery_path(gallery)
  end

  it "" do
    page
    attach_file "Image", './spec/images/flower.gif'
    click_button "Update Gallery"
    image = Image.last
    expect(image.content_identifier).to eq "flower.gif"
    expect(image.gallery_id).to be Gallery.last.id
  end

end
