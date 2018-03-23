require "acceptance_helper"

resource "Sessions", acceptance: :request do
  post '/api/v1/session/' do
    let!(:account) { create :account }
    let!(:account_email) { account.email }
    let!(:account_password) { account.password }
    let!(:session_device_token) { SecureRandom.hex(10) }

    with_options scope: :account do
      parameter :email, 'Account email', required: true
      parameter :password, 'Account password', required: true
    end
    with_options scope: :session do
      parameter :device_token, "Account device token"
    end

    example_request 'Sign in (valid)' do
      expect(status).to eq 200
    end

    example 'Sign in (invalid)' do
      do_request(account: { email: '', password: '' })
      expect(status).to eq 422
    end
  end

  delete '/api/v1/session/' do
    let(:account) { create :account, :with_session }
    let(:session) { account.sessions.take }
    before { header 'Access-Token', session.access_token }

    example_request 'Sign out' do
      expect(status).to eq 200
    end
  end
end
