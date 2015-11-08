require 'capybara'

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
  let(:locals){{ article: :article }}

  let(:presenter){ double :presenter }

  subject(:div){ Capybara.string(rendering).text }
  
  before do
    def bind.present obj; end
    expect(bind).to receive(:present).with(:article).and_yield(presenter)
    expect(presenter).to receive(:create_gallery_link){ :link }
  end

  describe "Create gallery link" do
    it{ should include "link" }
  end

end
