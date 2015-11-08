require 'capybara'

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
  let(:locals){{ image: :image }}

  let(:builder){ double :builder }

  subject(:div){ Capybara.string(rendering).text }
  
  before do
    def bind.form_for obj; end
    expect(bind).to receive(:form_for).with(:image).and_yield(builder)
    expect(builder).to receive(:hidden_field).with(:gallery_id){ "gallery_id" }
    expect(builder).to receive(:label).with(:content,"Image"){ "content_label" }
    expect(builder).to receive(:file_field).with(:content){ "content_file_field" }
    expect(builder).to receive(:submit).with("Add Image"){ "submit" }
  end

  describe "Gallery id hidden field" do
    it{ should include "gallery_id" }
  end

  describe "Content file field" do
    it{ should match /content_label\s*content_file_field/m }
  end


  describe "Add image button" do
    it{ should include "submit" }
  end

end
