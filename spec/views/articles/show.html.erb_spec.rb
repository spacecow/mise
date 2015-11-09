require 'capybara'
require 'rspec/its'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "articles/show.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/articles/show.html.erb" }
  let(:locals){{ article:article, gallery: :gallery, image: :image }}

  let(:presenter){ double :presenter }
  let(:article){ double :article }

  subject(:page){ Capybara.string(rendering) }
  
  before do
    def bind.render obj, hash={}; end
    def bind.present obj; end
    expect(bind).to receive(:render).with("images/form", image: :image){ "form" }
    expect(bind).to receive(:present).with(:gallery).and_yield(presenter)
    expect(presenter).to receive(:images).with(no_args){ "images" }
    expect(article).to receive(:title).with(no_args){ "a fancy book" }
  end

  describe "Display article title" do
    subject{ page.find 'h1' }
    its(:text){ should include "a fancy book" }
  end

  describe "List images" do
    subject{ page.find 'div#links' }
    its(:text){ should include "images" }
  end

  describe "Image form" do
    subject{ page.find 'div.form.image' }
    its(:text){ should include "form" }
  end

end
