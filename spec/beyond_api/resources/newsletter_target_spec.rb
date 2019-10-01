# frozen_string_literal: true

require "spec_helper"

RSpec.describe BeyondApi::NewsletterTarget do
  describe "#create" do
    it "returns a Hash on successful request" do
      expect(@session.categories.all).to be_a Hash
    end
  end

  describe "#find" do
    it "returns a Hash on successful request"
  end

  describe "#update" do
    it "returns a Hash on successful request"
  end

  describe "#delete" do
    it "returns true on successful request"
  end
end
