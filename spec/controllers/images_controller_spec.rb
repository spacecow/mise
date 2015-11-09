describe "ImagesController" do

  let(:controller){ ImagesController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/images_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ image: :image }}
    let(:image){ double :image }
    before do
      expect(controller).to receive(:redirect_to).with(:article){ :redirect }
      expect(repo).to receive(:create_image).with(:image){ image }
      expect(image).to receive(:article).with(no_args){ :article }
    end
    it("success and redirect"){ should eq :redirect }
    pending("failure and render")
  end

end
