# frozen_string_literal: true

RSpec.describe 'BeyondApi::Utils' do
  let!(:file_path) do
    app_root = File.expand_path(File.dirname("ext.rb"))
    "#{app_root}/spec/files/"
  end

  it "return image content type" do
    file = "#{file_path}image1.png"

    expect(BeyondApi::Utils.file_content_type(file)).to eq "image/png"
  end

  it "parse snakecase to camelcase" do
    expect("sales_price".camelize(false)).to eq "salesPrice"
  end
end
