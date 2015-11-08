require './spec/helpers/database_helper'
require './spec/helpers/image_helper'

require './spec/helpers/factory_helper'
require './spec/helpers/gallery_helper'
require './spec/helpers/article_helper'

describe Image do

  describe "Validations" do

    let(:gallery){ create :gallery }
    let(:gallery_id){ gallery.id }
    let(:params){{ gallery_id:gallery_id }}

    subject{ -> { Image.create params }}

    context "Image is valid" do
      it{ should change(Image, :count).from(0).to(1) } 
      after do
        Image.delete_all
        Gallery.delete_all
        Article.delete_all
      end
    end

    context "Gallery_id is nil" do
      let(:gallery_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation"
      }}
    end

    context "Gallery_id points to a non-existing model" do
      let(:gallery_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::InvalidForeignKey
        expect(e.message).to include "PG::ForeignKeyViolation"
      }}
    end

  end
end
