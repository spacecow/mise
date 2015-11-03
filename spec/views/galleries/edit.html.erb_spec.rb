require 'capybara'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "galleries/edit.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.
    sub(/<%= form_for/,'<% form_for').
    sub(/<%= f.fields_for/,'<% f.fields_for') }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/galleries/edit.html.erb" }
  let(:locals){{ gallery:gallery }}

  let(:gallery){ double :gallery }
  let(:gallery_form){ double :gallery_form }
  let(:image){ double :image }
  let(:image_form){ double :image_form }

  before do
    def bind.form_for mdl, opt={}; end
    expect(bind).to receive(:form_for).with(gallery, as: :gallery).and_yield(gallery_form)
    expect(gallery).to receive(:images){ [image] }
    expect(gallery_form).to receive(:fields_for).
      with("images_attributes[]",image).and_yield(image_form)
    expect(image_form).to receive(:label).with(:content, "Image 1")
    expect(image_form).to receive(:file_field).with(:content, index:nil)
    expect(gallery_form).to receive(:submit)
  end

  subject(:div){ Capybara.string(rendering).find(".gallery") }

  it{ subject }

end

if false

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end


  let(:locals){{ sentence:sentence }}

  let(:sentence){ double :sentence }
  let(:presenter){ double :presenter }

  before do
    def bind.present mdl; end
    bind.should_receive(:present).with(sentence).and_yield presenter
    bind.should_receive(:title).with(:japanese){ "japanese" }
    bind.should_receive(:subtitle).with(:english){ "english" }
    presenter.should_receive(:glossaries){ "glossaries" }
    presenter.should_receive(:edit_link){ "edit glossary" }
    sentence.should_receive(:japanese){ :japanese }
    sentence.should_receive(:english){ :english }
  end

  context "glossary list" do
    subject{ div.find("ul.glossaries").text.strip }
    it{ should eq "glossaries" }
  end

  context "footer section" do
    subject{ div.find(".footer").text.strip }
    it{ should eq "edit glossary" }
  end

end
