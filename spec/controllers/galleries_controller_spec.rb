describe "GalleriesController" do

  let(:controller){ GalleriesController.new }
  let(:repo){ double :repo }
  let(:gallery){ {} }
  let(:params){{ id: :id, gallery: gallery, article_id: :article_id }}

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/galleries_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    before do
      expect(controller).to receive(:redirect_to).with(:article){ :redirect }
      expect(repo).to receive(:article).with(:article_id){ :article }
      expect(repo).to receive(:create_gallery).with(:article)
    end
    it("success and redirect"){ should eq :redirect }
    pending("failure and render")
  end

  describe "#edit" do
    let(:function){ :edit }
    let(:form){ double :form }
    let(:images){ double :images }
    before do
      expect(repo).to receive(:gallery_form).with(:id){ form }
      expect(form).to receive(:images).with(no_args){ images }
      expect(images).to receive(:build).with(no_args)
    end
    it("render page"){ subject }
  end

  describe "#update" do
    let(:function){ :update }
    let(:form){ double :form }
    before do
      expect(repo).to receive(:gallery_form).with(:id){ form }
      expect(repo).to receive(:update_gallery).with(form,gallery)
    end

    context "success and redirect" do
      before do
        expect(controller).to receive(:gallery_path).with(:form_id){ :path }
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
        expect(form).to receive(:id).with(no_args){ :form_id }
      end
      context "gallery params exist" do
        it{ should eq :redirect }
      end
      context "gallery params is not present" do
        let(:gallery){ nil }
        it{ should eq :redirect }
      end
    end

    context "image is present" do
      let(:gallery){{ image: :image }}
      before do 
        expect(controller).to receive(:render).with(:crop){ :crop }
      end
      it{ subject }
    end

    pending("failure and render")
  end

end
