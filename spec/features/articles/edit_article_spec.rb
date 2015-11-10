require 'rails_helper'

describe "Edit article" do

  let(:article){ create :article, title:"a book" }
  let(:gallery){ create :gallery, article:article }

  before do
    gallery
    visit edit_article_path(article)
  end

  it "update article" do
    expect(page).to have_field('Article', with:"a book")
    fill_in "Article", with:"an updated book"
    click_button "Update Article"
    article = Article.last
    expect(Article.count).to be 1
    expect(article.title).to eq "an updated book"
    expect(current_path).to eq article_path(article)
  end

end
