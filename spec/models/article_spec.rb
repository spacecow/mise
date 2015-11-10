require './spec/helpers/database_helper'
require './spec/helpers/article_helper'

describe Article do

  describe "Validations" do

    let(:title){ 'a title' }
    let(:params){{ title:title }}
    subject{ -> { Article.create params }}

    context "Article is valid" do
      it{ should change(Article, :count).from(0).to(1) } 
      after{ Article.delete_all }
    end

    context "Title is nil" do
      let(:title){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation"
      }}
    end

    context "Title is blank" do
      let(:title){ "" }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::CheckViolation"
      }}
    end

  end

end
