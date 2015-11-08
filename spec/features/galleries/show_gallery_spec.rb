require 'rails_helper'

describe "Show gallery" do

  let(:gallery){ create :gallery }

  before do
    visit gallery_path(gallery)
  end

  it "create gallery" do
    click_button "Add Image"
    image = Image.last
    expect(Image.count).to be 1
    expect(image.gallery_id).to be gallery.id
    expect(current_path).to eq gallery_path(gallery)
  end

end
