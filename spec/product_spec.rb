RSpec.describe BeyondApi::Products do
  before do
    @session = BeyondApi::Session.new(api_url: ENV['SHOP_URL'])
    @session.token.client_credentials
    puts @session.token
  end

  it 'Find a product sending an ID' do
    product = @session.products.find(ENV['PRODUCT_ID'])
    expect(product).not_to be nil
  end

  it "Upload multiple images" do
    images = @session.products.upload_multiple_images(ENV['PRODUCT_ID'],
                                                      ['/home/gsanemeterio/Pictures/dummyImage600x400.png',
                                                       '/home/gsanemeterio/Pictures/dummyImage400x400.png'],
                                                      ['file1.png', 'file2.png'])
    expect(images).not_to be nil
    expect(images.embedded.images.is_a?).to eq true
  end

end
