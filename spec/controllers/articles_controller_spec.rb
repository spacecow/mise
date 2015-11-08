describe "ArticlesController" do

  let(:controller){ ArticlesController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require 'action_controller'
    require './app/controllers/articles_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before{ expect(repo).to receive(:article).with(:id){ :article }}
    it{ should eq :article }
  end

  describe "#index" do
    let(:function){ :index }
    before{ expect(repo).to receive(:new_article).with(no_args){ :article }}
    it{ should eq :article }
  end

  describe "#create" do
    let(:function){ :create }
    let(:params){ ActionController::Parameters.new({ article: :article }) }
    before do
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:articles_path).with(no_args){ :path }
      expect(repo).to receive(:create_article).with(:article)
    end
    it{ should eq :redirect }
  end

end
