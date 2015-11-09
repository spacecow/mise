require 'capybara'
require 'rspec/its'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "articles/edit.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read(filepath).sub(/<%= form_for/,'<% form_for') }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/articles/edit.html.erb" }
  let(:locals){{ article: :article, articles: :articles }}

  subject(:page){ Capybara.string(rendering) }
  
  before do
    def bind.render obj, hash={}; end
    expect(bind).to receive(:render).with("form", article: :article){ "form" }
  end

  describe "Article form" do
    subject{ page.find 'div.form.article' }
    its(:text){ should include "form" }
  end

end
