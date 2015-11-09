require 'capybara'
require 'rspec/its'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "galleries/show.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read(filepath).sub(/<%= form_for/,'<% form_for') }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/galleries/show.html.erb" }
  let(:locals){{ image: :image, gallery: :gallery }}

  let(:presenter){ double :presenter }

  subject(:page){ Capybara.string(rendering) }
  
  before do
    def bind.present obj; end
    def bind.render obj, hash={}; end
    expect(bind).to receive(:present).with(:gallery).and_yield(presenter)
    expect(bind).to receive(:render).with("images/form", image: :image){ "form" }
    expect(presenter).to receive(:images).with(no_args){ "images" }
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
