require 'rails_helper'

describe "Index articles" do

  before do
    visit articles_path
  end

  it "Create article" do
    fill_in "Article", with:"a book"
    click_button "Create Article"
    article = Article.last
    expect(Article.count).to be 1
    expect(article.title).to eq "a book"
  end

end

