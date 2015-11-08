require 'rails_helper'

describe "Show gallery" do

  let(:gallery){ create :gallery }

  before do
    visit gallery_path(gallery)
  end

  it "create gallery" do
    attach_file "Image", './spec/images/flower.gif'
    click_button "Add Image"
    image = Image.last
    expect(Image.count).to be 1
    expect(image.gallery_id).to be gallery.id
    expect(image.content_identifier).to eq "flower.gif" 
    expect(current_path).to eq gallery_path(gallery)
  end

end
