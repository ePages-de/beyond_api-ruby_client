# frozen_string_literal: true

RSpec.describe BeyondApi::Authentication::UserAndPassword, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  let(:user_id) { ENV.fetch('COCKPIT_USER_ID', nil) }
  let(:user_name) { ENV.fetch('COCKPIT_USER_NAME', nil) }
  let(:user_email) { ENV.fetch('COCKPIT_USER_EMAIL', nil) }
  let(:user_password) { ENV.fetch('COCKPIT_USER_PASSWORD', nil) }

  describe '#verify_password' do
    let(:new_password) { 'ValidPassword123' }

    it 'sends a post request with the correct parameters' do
      # client.verify_password('merchant', new_password)
    end
  end

  describe '#change_password' do
    let(:new_password) { 'ValidPassword123' }

    it 'sends a post request with the correct parameters' do
      # client.change_password(
      #   user_id,
      #   user_password,
      #   new_password
      # )
    end

    after do
      # # Rollback the password change
      # client.change_password(
      #   user_id,
      #   new_password,
      #   user_password
      # )
    end
  end

  describe '#password_reset_email' do
    it 'sends a post request with the correct parameters' do
      # client.password_reset_email(user_email)
    end
  end

  describe '#change_username' do
    let(:new_name) { 'test-user' }

    it 'sends a post request with the correct parameters' do
      # client.change_username(
      #   user_id,
      #   user_password,
      #   new_name
      # )
    end

    after do
      # # Rollback the username change
      # client.change_username(
      #   user_id,
      #   user_password,
      #   user_name
      # )
    end
  end
end
