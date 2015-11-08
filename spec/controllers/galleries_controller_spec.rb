describe "GalleriesController" do

  let(:controller){ GalleriesController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/galleries_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:gallery).with(:id){ :gallery }
      expect(repo).to receive(:build_image).with(:gallery){ :image }
    end
    it{ should eq :image }
  end

  describe "#create" do
    let(:function){ :create }
    let(:params){{ article_id: :article_id }}
    before do
      expect(controller).to receive(:redirect_to).with(:gallery){ :redirect }
      expect(repo).to receive(:article).with(:article_id){ :article }
      expect(repo).to receive(:create_gallery).with(:article){ :gallery }
    end
    it("success and redirect"){ should eq :redirect }
    pending("failure and render")
  end

end
