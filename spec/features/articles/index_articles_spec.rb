require 'rails_helper'

describe "Index articles" do

  let(:article){ nil }

  before do
    article
    visit articles_path
  end

  context "List articles" do
    let(:article){ create :article, title:'a fancy book' }
    it "" do
      expect(page.text).to include 'a fancy book'
    end
  end

  it "Create article" do
    fill_in "Article", with:"a book"
    click_button "Create Article"
    article = Article.last
    expect(Article.count).to be 1
    expect(article.title).to eq "a book"
  end

end

