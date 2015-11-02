require './spec/helpers/database_helper'
require './spec/helpers/gallery_helper'
require './spec/helpers/article_helper'
require './spec/helpers/factory_helper'

describe Gallery do

  describe "validations" do

    let(:article){ create :article }
    let(:article_id){ article.id }
    let(:params){{ article_id:article_id }}
    subject{ -> { Gallery.create params }}

    context "gallery is valid" do
      it{ should change(Gallery, :count).from(0).to(1) } 
      after do
        Gallery.delete_all
        Article.delete_all
      end
    end

    context "article_id is nil" do
      let(:article_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation"
      }}
    end

    context "article_id points to a non-existing model" do
      let(:article_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::InvalidForeignKey
        expect(e.message).to include "PG::ForeignKeyViolation"
      }}
    end

  end

end
