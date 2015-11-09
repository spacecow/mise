require 'capybara'
require 'rspec/its'

class ErbBinding
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set('@' + key.to_s, value)
    end
  end
end

describe "images/_form.html.erb" do

  let(:bind){ ErbBinding.new({}) }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read(filepath).sub(/<%= form_for/,'<% form_for') }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/images/_form.html.erb" }

  let(:builder){ double :builder }

  subject(:page){ Capybara.string(rendering) }
  
  before do
    def bind.form_for obj; end
    def bind.image; end
    expect(bind).to receive(:image).with(no_args){ :image }
    expect(bind).to receive(:form_for).with(:image).and_yield(builder)
    expect(builder).to receive(:hidden_field).with(:gallery_id){ "gallery_id" }
    expect(builder).to receive(:label).with(:content,"Image"){ "content_label" }
    expect(builder).to receive(:file_field).with(:content){ "content_file_field" }
    expect(builder).to receive(:submit).with("Add Image"){ "submit" }
  end

  describe "Gallery id hidden field" do
    its(:text){ should include "gallery_id" }
  end

  describe "Content file field" do
    its(:text){ should match /content_label\s*content_file_field/m }
  end

  describe "Add image button" do
    its(:text){ should include "submit" }
  end

end
