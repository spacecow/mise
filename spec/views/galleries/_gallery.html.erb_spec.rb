require 'capybara'
require 'rspec/its'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "galleries/_gallery.html.erb" do

  let(:bind){ ErbBinding.new({}) }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/galleries/_gallery.html.erb" }

  let(:presenter){ double :presenter }
  let(:article){ double :article }

  subject(:page){ Capybara.string(rendering) }
  
  before do
    def bind.render obj, hash={}; end
    def bind.present obj; end
    def bind.gallery; end
    def bind.image; end
    expect(bind).to receive(:render).with("images/form", image: :image){ "form" }
    expect(bind).to receive(:present).with(:gallery).and_yield(presenter)
    expect(bind).to receive(:gallery).with(no_args){ :gallery }
    expect(bind).to receive(:image).with(no_args){ :image }
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
