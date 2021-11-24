RSpec.describe BeyondApi do
  it "has a version number" do
    expect(BeyondApi::VERSION).not_to be nil
  end

  it 'return image content type' do
    file = ENV['PRODUCT_IMAGE1_PATH']

    expect(BeyondApi::Utils.file_content_type(file)).to eq 'image/png'
  end
end
