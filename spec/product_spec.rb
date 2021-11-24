RSpec.describe BeyondApi do
  before do
    @session = BeyondApi::Session.new(api_url: ENV['SHOP_URL'])
    @session.token.client_credentials
  end

  it 'Find a product sending an ID' do
    product = @session.products.find(ENV['PRODUCT_ID'])
    expect(product).not_to be nil
  end

  it "Upload multiple images" do
    files = [ENV['PRODUCT_IMAGE1_PATH'], ENV['PRODUCT_IMAGE2_PATH']]

    images = @session.products.upload_multiple_images(ENV['PRODUCT_ID'],
                                                      files,
                                                      ['file1.png', 'file2.png'])
    expect(images).not_to be nil
    expect(images.embedded.images.is_a?(Array)).to eq true
  end

  it "Upload a single image" do
    file = ENV['PRODUCT_IMAGE1_PATH']

    image = @session.products.upload_image(ENV['PRODUCT_ID'], file, 'file_single.png')
    expect(image).not_to be nil
    expect(image).to eq true
  end

end
