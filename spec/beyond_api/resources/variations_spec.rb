# frozen_string_literal: true

RSpec.describe 'BeyondApi::Variations' do
  let!(:file_path) do
    app_root = File.expand_path(File.dirname("ext.rb"))
    "#{app_root}/spec/files/"
  end

  let!(:session) do
    session = BeyondApi::Session.new(api_url: ENV["API_URL"])
    session.token.client_credentials
  end

  let(:product) { session.products.create(FactoryBot.build(:product, :with_variations)) }
  let(:variation) do
    session.variations.all(product.id).embedded.variations.first
  end
  let(:default_image_property) do
    body = [{
      property: "defaultImage",
      enabled: true
    }]
    session.products.update_variation_properties(product.id,  body)
  end

  context "Create variation" do
    it "Update image variation property" do
      body = [{
        property: "defaultImage",
        enabled: true
      }]
      response = session.products.update_variation_properties(product.id,  body)

      expect(response).not_to be nil
      default_image_prop = response.embedded.variation_properties.find { |prop| prop.property == "defaultImage" }

      expect(default_image_prop).not_to be nil
      expect(default_image_prop.enabled).to be true
    end

    it "Upload multiple images" do
      files = [
        "#{file_path}image1.png",
        "#{file_path}image2.png"
      ]

      default_image_property
      response = session.variations.upload_multiple_images(product.id,
                                                           variation.id,
                                                           files,
                                                           ["image1.png", "image2.png"])

      expect(response).not_to be nil
    end

    it "Upload a single image" do
      file = "#{file_path}image1.png"

      default_image_property
      response = session.variations.upload_multiple_images(product.id,
                                                           variation.id,
                                                           file,
                                                           "variation1.png")

      expect(response).not_to be nil
    end

    it "sort variation images" do
      files = [
        "#{file_path}image1.png",
        "#{file_path}image2.png"
      ]

      default_image_property
      response = session.variations.upload_multiple_images(product.id,
                                                           variation.id,
                                                           files,
                                                           ["image1.png", "image2.png"])

      images = session.variations.images(product.id, variation.id)

      images_sorted = images.embedded.images.sort_by(&:position).reverse.map(&:id)

      sorted = session.variations.sort_images(product.id, variation.id, images_sorted)

      images = session.variations.images(product.id, variation.id)

      expect(sorted).not_to be nil
      expect(sorted).to eq true
      expect(images.embedded.images.map(&:id)).to eq images_sorted
    end
  end
end
