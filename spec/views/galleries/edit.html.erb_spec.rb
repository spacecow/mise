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
    gsub(/<%= f.fields_for/,'<% f.fields_for') }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/galleries/edit.html.erb" }
  let(:locals){{ gallery:gallery }}

  let(:gallery){ double :gallery }
  let(:gallery_form){ double :gallery_form }
  let(:image){ double :image }
  let(:image_form){ double :image_form }
  let(:image_id){ 1 }

  before do
    def bind.form_for mdl, opt={}; end
    expect(bind).to receive(:form_for).with(gallery, as: :gallery).
      and_yield(gallery_form)
    expect(gallery_form).to receive(:fields_for).
      with("image[][]",image,index:image_id ? image_id : 0).
      and_yield(image_form)
    expect(gallery_form).to receive(:submit)
    expect(gallery).to receive(:images){ [image] }
    expect(image).to receive(:id){ image_id }
    expect(image_form).to receive(:label).with(:content, "Image 1")
    expect(image_form).to receive(:file_field).with(:content)
  end

  subject(:div){ Capybara.string(rendering).find(".gallery") }

  context "new record" do
    it{ subject }
  end

  context "old record" do
    let(:image_id){ nil }
    it{ subject }
  end

end
