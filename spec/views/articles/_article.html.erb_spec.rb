require 'capybara'
require 'rspec/its'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "articles/_article.html.erb" do

  let(:bind){ ErbBinding.new({}) }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/articles/_article.html.erb" }

  let(:article){ double :article }

  subject(:li){ Capybara.string(rendering).find('li.article') }
  
  before do
    def bind.edit_article_path obj; end
    def bind.link_to link, path; end
    def bind.article; end
    expect(bind).to receive(:edit_article_path).with(article){ :path }
    expect(bind).to receive(:link_to).with("Edit",:path){ "edit link" }
    allow(bind).to receive(:article).with(no_args){ article }
    expect(article).to receive(:title).with(no_args){ "a fancy book" }
  end

  describe "Title" do
    subject{ li.find 'span.title' }
    its(:text){ should eq "a fancy book" }
  end

  describe "Actions" do
    subject(:actions){ li.find 'span.actions' }

    describe "Edit" do
      subject{ actions.find 'span.edit' }
      its(:text){ should eq "edit link" }
    end
  end

end
