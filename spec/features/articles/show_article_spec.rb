require 'rails_helper'

describe "show article" do

  let(:article){ create :article }

  it "" do
    visit article_path(article)
  end

end
