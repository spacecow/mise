require 'rails_helper'

describe "show article" do

  let(:article){ create :article }

  before do
    visit article_path(article)
  end

  it "create gallery" do
    click_link "Create Gallery"
    gallery = Gallery.last
    expect(Gallery.count).to be 1
    expect(gallery.article_id).to be article.id
    expect(current_path).to eq article_path(article)
  end

end
