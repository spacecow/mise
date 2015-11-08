describe "ArticlesController" do

  let(:controller){ ArticlesController.new }
  let(:repo){ double :repo }
  let(:params){{ id: :id }}

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/articles_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    before{ expect(repo).to receive(:article).with(:id){ :article }}
    it{ should eq :article }
  end

end
