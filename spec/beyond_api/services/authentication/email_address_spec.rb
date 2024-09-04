# frozen_string_literal: true

RSpec.describe BeyondApi::Authentication::EmailAddress, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  let(:user_id) { ENV.fetch('COCKPIT_USER_ID', nil) }
  let(:user_email) { ENV.fetch('COCKPIT_USER_EMAIL', nil) }
  let(:user_password) { ENV.fetch('COCKPIT_USER_PASSWORD', nil) }

  let(:new_email) { 'team42-new@epages.com' }

  describe '#trigger_change' do
    it 'change email address' do
      # client.trigger_change(user_id, 'en-US', user_password, new_email)
    end

    after do
      # # Rollback email address change
      # client.trigger_change(user_id, 'en-US', user_password, user_email)
    end
  end
end
