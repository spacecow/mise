require './spec/helpers/database_helper'
require './spec/helpers/article_helper'

describe Article do

  describe "validations" do

    let(:params){ {} }
    subject{ -> { Article.create params }}

    context "article is valid" do
      it{ should change(Article, :count).from(0).to(1) } 
      after{ Article.delete_all }
    end

  end

end
