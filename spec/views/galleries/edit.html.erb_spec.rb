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
  let(:file){ File.read(filepath).sub(/<%= form_for/,'<% form_for') }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/galleries/edit.html.erb" }
  let(:locals){{ form: :form }}

  let(:builder){ double :builder }
  let(:presenter){ double :presenter }

  subject(:div){ Capybara.string(rendering).find(".gallery") }
  
  before do
    def bind.form_for obj, opt; end
    def bind.present obj, builder; end
    expect(bind).to receive(:form_for).with(:form, as: :gallery).
      and_yield(builder)
    expect(bind).to receive(:present).with(:form, builder).
      and_yield(presenter)
    expect(presenter).to receive(:images)
    expect(builder).to receive(:submit).with(no_args)
  end

  context "new record" do
    it{ subject }
  end

end
