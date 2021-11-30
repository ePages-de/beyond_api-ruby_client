# frozen_string_literal: true

RSpec.describe BeyondApi do
  let!(:app_root) { File.expand_path(File.dirname("ext.rb")) }

  it "has a version number" do
    expect(BeyondApi::VERSION).not_to be nil
  end

  it "return image content type" do
    file = "#{app_root}/spec/files/image1.png"

    expect(BeyondApi::Utils.file_content_type(file)).to eq "image/png"
  end

  it "parse snakecase to camelcase" do
    expect("sales_price".camelize(false)).to eq "salesPrice"
  end
end
