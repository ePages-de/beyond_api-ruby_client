# frozen_string_literal: true

require "spec_helper"

RSpec.describe BeyondApi::Users do
  before(:all) do
    @password = Faker::Internet.password(min_length: 8, special_characters: true)
    @user = @session.users.create({ email:    Faker::Internet.email,
                                    username: Faker::Internet.username,
                                    password: @password })
  end

  describe "#all" do
    it "returns a Hash on successful request" do
      expect(@session.users.all).to be_a Hash
    end
  end

  describe "#find" do
    it "returns a Hash on successful request" do
      expect(@session.users.find(@user["id"])).to be_a Hash
    end
  end

  describe "#create" do
    it "returns a Hash on successful request" do
      @session.users.create({ email:    Faker::Internet.email,
                              username: Faker::Internet.username,
                              password: Faker::Internet.password(min_length: 8, special_characters: true) })
    end
  end

  describe "#roles" do
    it "returns a Hash on successful request" do
      expect(@session.users.roles(@user["id"])).to be_a Hash
    end
  end

  describe "#set_roles" do
    it "returns true on successful request"
  end

  describe "#add_roles" do
    it "returns true on successful request"
  end

  describe "#search_by_username" do
    it "returns a Hash on successful request" do
      expect(@session.users.search_by_username(@user["username"])).to be_a Hash
    end
  end

  describe "#verify_password" do
    it "returns true on successful request" do
      expect(@session.users.verify_password("ValidPassword!")).to be true
    end
  end

  describe "#change_password" do
    it "returns true on successful request" do
      expect(@session.users.change_password(@user["id"], @password, @password)).to eq true
    end
  end

  describe "#send_reset_password_email" do
    it "returns true on successful request" do
      expect(@session.users.send_reset_password_email(@user["email"], "en-US")).to eq true
    end
  end

  describe "#change_username" do
    it "returns a Hash on successful request" do
      expect(@session.users.change_username(@user["id"], @user["username"], @password)).to be_a Hash
    end
  end

  describe "#support_access" do
    it "returns a Hash on successful request" do
      expect(@session.users.support_access).to be_a Hash
    end
  end

  describe "#enable_support_access" do
    it "returns true on successful request" do
      expect(@session.users.enable_support_access).to be true
    end
  end

  describe "#disable_support_access" do
    it "returns true on successful request" do
      expect(@session.users.disable_support_access).to be true
    end
  end

  describe "#send_email_address_change" do
    it "returns true on successful request" do
      expect(@session.users.send_email_address_change(@user["id"], @user["email"], @password, "en-US")).to be true
    end
  end
end
