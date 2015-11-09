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
    let(:article){ double :article }
    before do
      expect(repo).to receive(:article).with(:id){ article }
      expect(repo).to receive(:build_image).with(:gallery){ :image }
      expect(article).to receive(:gallery).with(no_args){ :gallery }
    end
    it{ should eq :image }
  end

  describe "#index" do
    let(:function){ :index }
    before do
      expect(repo).to receive(:articles).with(no_args){ :articles }
      expect(repo).to receive(:new_article_form).with(no_args){ :form }
    end
    it{ subject }
  end

  describe "#create" do
    let(:function){ :create }
    let(:params){ ActionController::Parameters.new({ article: :article }) }
    let(:form){ double :form }
    before do
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:articles_path).with(no_args){ :path }
      expect(repo).to receive(:new_article_form).with(no_args){ form }
      expect(form).to receive(:save).with(:article){ true }
    end
    it{ should eq :redirect }
  end

  describe "#edit" do
    let(:function){ :edit }
    let(:params){{ id: :id }}
    before{ expect(repo).to receive(:article).with(:id){ :article }}
    it{ should eq :article }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){ ActionController::Parameters.new({ id: :id, article: :article })}
    before do
      expect(controller).to receive(:redirect_to).with(:article){ :redirect }
      expect(repo).to receive(:article).with(:id){ :article }
      expect(repo).to receive(:update_article).with(:article, :article)
    end
    it{ should eq :redirect }
  end

end
