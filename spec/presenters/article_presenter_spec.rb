require './app/presenters/article_presenter'

describe ArticlePresenter do

  let(:presenter){ ArticlePresenter.new article, view }
  let(:article){ double :article }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#create_gallery_link" do
    let(:function){ :create_gallery_link }
    before do
      expect(view).to receive(:link_to).with("Create Gallery", :path, method: :post){ :link }
      expect(view).to receive(:galleries_path).with(article_id: :id){ :path }
      expect(article).to receive(:id).with(no_args){ :id }
    end
    it{ should eq :link }
  end

end
