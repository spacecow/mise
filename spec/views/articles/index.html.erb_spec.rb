require 'capybara'
require 'rspec/its'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "articles/index.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read(filepath).sub(/<%= form_for/,'<% form_for') }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/articles/index.html.erb" }
  let(:locals){{ article: :article }}

  let(:builder){ double :builder }

  subject{ Capybara.string(rendering) }
  
  before do
    def bind.form_for obj; end
    expect(bind).to receive(:form_for).with(:article).and_yield(builder)
    expect(builder).to receive(:label).with(:title,"Article"){ "title_label" }
    expect(builder).to receive(:text_field).with(:title){ "title_text_field" }
    expect(builder).to receive(:submit).with("Create Article"){ "submit" }
  end

  describe "Title text field" do
    its(:text){ should match /title_label\s*title_text_field/m }
  end

  describe "Create article button" do
    its(:text){ should include "submit" }
  end

end
