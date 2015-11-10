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
    it{ subject }
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
      expect(repo).to receive(:new_article_form).with(no_args){ form }
      expect(form).to receive(:save).with(:article){ success }
    end

    context "successful creation" do
      let(:success){ true }
      before do
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
        expect(controller).to receive(:articles_path).with(no_args){ :path }
      end
      it{ should eq :redirect }
    end

    context "failure during creation" do
      let(:success){ false }
      before do
        expect(repo).to receive(:articles).with(no_args){ :articles }
        expect(controller).to receive(:render).with(:index){ :render }
      end
      it{ should eq :render }
    end
  end

  describe "#edit" do
    let(:function){ :edit }
    let(:params){{ id: :id }}
    before{ expect(repo).to receive(:article_form).with(:id){ :form }}
    it{ subject }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){ ActionController::Parameters.new({ id: :id, article: :article })}
    let(:form){ double :form }
    before do
      expect(repo).to receive(:article_form).with(:id){ form }
      expect(form).to receive(:update).with(:article){ success }
    end

    context "successful update" do
      let(:success){ true }
      before do
        expect(controller).to receive(:redirect_to).with(form){ :redirect }
      end
      it{ should eq :redirect }
    end

    context "failure during update" do
      let(:success){ false }
      before do
        expect(controller).to receive(:render).with(:edit){ :render }
      end
      it{ should eq :render }
    end
  end
end
