require 'faker'

RSpec.describe BeyondApi do
  let!(:session) do
    session = BeyondApi::Session.new(api_url: ENV['SHOP_URL'])
    session.token.client_credentials
  end

  let(:product) { @product = session.products.create(FactoryBot.build(:product)) }

  let!(:app_root) { File.expand_path(File.dirname("ext.rb")) }
  let!(:file_path) { "#{app_root}/spec/files/"}

  after(:all) do
    # session = BeyondApi::Session.new(api_url: ENV['SHOP_URL'])
    # session.token.client_credentials

    # product = session.products.all
  end

  describe 'non existing product' do
    it 'create a new regular product and ' do
      product = session.products.create(FactoryBot.build(:product))

      expect(product).not_to be nil
      expect(product.id).not_to be nil
    end
  end


  describe 'product exist' do
    it 'find a product sending an ID' do
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
                                                        ['image1.png', 'image2.png'])
      expect(images).not_to be nil
      expect(images.embedded.images.is_a?(Array)).to eq true
    end

    it "upload a single image" do
      file = "#{file_path}image1.png"

      image = session.products.upload_image(product.id, file, 'image3.png')
      expect(image).not_to be nil
      expect(image).to eq true
    end

    it "upload more than 10 images with single call" do
      files = ["#{file_path}image1.png"] * 20
      image_names = Array.new(20) { |index| "image#{index+1}.png" }
      images = session.products.upload_all_multiple_images(product.id,
                                                           files,
                                                           image_names)
      expect(images).not_to be nil
      expect(images.embedded.images.is_a?(Array)).to eq true
      expect(images.embedded.images.size).to eq 20
    end

    xit "return an error when upload more than 50 images" do
      files = ["#{file_path}image1.png"] * 51
      image_names = Array.new(51) { |index| "image#{index+1}.png" }
      images = session.products.upload_all_multiple_images(product.id,
                                                           files,
                                                           image_names)
      expect(images).not_to be nil
      puts images
      expect(images.embedded.images.is_a?(Array)).to eq true
      expect(images.embedded.images.size).to eq 20
    end
  end
end
