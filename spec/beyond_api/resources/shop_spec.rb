# frozen_string_literal: true

require "spec_helper"

RSpec.describe BeyondAPI::Shop do
  describe "#address" do
    it "returns a Hash on successful request" do
      expect(@session.shop.address).to be_a Hash
    end
  end

  describe "#attribute" do
    it "returns a Hash on successful request"
  end

  describe "#attributes" do
    it "returns a Hash on successful request" do
      expect(@session.shop.attributes).to be_a Hash
    end
  end

  describe "#close" do
    it "returns true on successful request" do
      expect(@session.shop.close).to be true
    end
  end

  describe "#create_attribute" do
    it "returns a Hash on successful request"
  end

  describe "#create_image" do
    it "returns true on successful request"
  end

  describe "#current" do
    it "returns a Hash on successful request" do
      expect(@session.shop.current).to be_a Hash
    end
  end

  describe "#delete_attribute" do
    it "returns true on successful request"
  end

  describe "#delete_image" do
    it "returns true on successful request"
  end

  describe "#image" do
    it "returns a Hash on successful request"
  end

  describe "#images" do
    it "returns a Hash on successful request" do
      expect(@session.shop.images).to be_a Hash
    end
  end

  describe "#legal_content" do
    it "returns a Hash on successful request"
  end

  describe "#legal_contents" do
    it "returns a Hash on successful request" do
      expect(@session.shop.legal_contents).to be_a Hash
    end
  end

  describe "#legal_details" do
    it "returns a Hash on successful request" do
      expect(@session.shop.legal_details).to be_a Hash
    end
  end

  describe "#open" do
    it "returns true on successful request" do
      expect(@session.shop.open).to be true
    end
  end

  describe "#search_images_by_label" do
    it "returns a Hash on successful request"
  end

  describe "#update" do
    it "returns a Hash on successful request"
  end

  describe "#update_address" do
    it "returns a Hash on successful request"
  end

  describe "#update_attribute" do
    it "returns a Hash on successful request"
  end

  describe "#update_legal_content" do
    it "returns a Hash on successful request"
  end

  describe "#update_legal_details" do
    it "returns a Hash on successful request"
  end

  describe "#upload_image" do
    it "returns true on successful request"
  end
end
