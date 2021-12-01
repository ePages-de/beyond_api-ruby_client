# frozen_string_literal: true

RSpec.describe 'BeyondApi::Products' do
  let!(:session) do
    session = BeyondApi::Session.new(api_url: ENV["SHOP_URL"])
    session.token.client_credentials
  end

  let(:product) { @product = session.products.create(FactoryBot.build(:product)) }

  let!(:file_path) do
    app_root = File.expand_path(File.dirname("ext.rb"))
    "#{app_root}/spec/files/"
  end

  describe "non existing product" do
    it "create a new regular product and " do
      product = session.products.create(FactoryBot.build(:product))

      expect(product).not_to be nil
      expect(product.id).not_to be nil
    end
  end


  describe "product exist" do
    it "find a product sending an ID" do
      response = session.products.find(product.id)
      expect(response).not_to be nil
      expect(response.id).to eq(product.id)
    end


    it "upload multiple images" do
      files = [
        "#{file_path}image1.png",
        "#{file_path}image2.png"
      ]

      images = session.products.upload_multiple_images(product.id,
                                                       files,
                                                       ["image1.png", "image2.png"])
      expect(images).not_to be nil
      expect(images.embedded.images.is_a?(Array)).to eq true
    end

    it "upload a single image" do
      file = "#{file_path}image1.png"

      image = session.products.upload_image(product.id, file, "image3.png")
      expect(image).not_to be nil
      expect(image).to eq true
    end
  end
end
