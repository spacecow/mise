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
  let(:locals){{ article:article, image: :image }}

  let(:article){ double :article }

  subject(:page){ Capybara.string(rendering) }
  
  before do
    def bind.render obj, hash={}; end
    expect(bind).to receive(:render).with(:gallery, image: :image){ "form" }
    expect(article).to receive(:title).with(no_args){ "a fancy book" }
    expect(article).to receive(:gallery).with(no_args){ :gallery }
  end

  describe "Display article title" do
    subject{ page.find 'h1' }
    its(:text){ should include "a fancy book" }
  end
end
