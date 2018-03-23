require "acceptance_helper"

resource "Accounts", acceptance: :request do
  let(:account) { create(:account, :with_session) }
  let(:session) { account.sessions.take }
  before { header 'Access-Token', session.access_token }

  get '/api/v1/account' do
    example_request 'Get account info' do
      expect(status).to eq 200
    end
  end

  put '/api/v1/account' do
    let(:account_email) { 'test@test.com' }
    let(:account_name) { 'Test Test' }
    let(:account_current_password) { account.password }
    let(:account_password) { 'new_password' }
    let(:account_password_confirmation) { 'new_password' }

    with_options scope: :account do
      parameter :email, 'Email'
      parameter :name, 'Name'
      parameter :current_password, 'Current password', required: true
      parameter :password, 'New password'
      parameter :password_confirmation, 'New password confirmation'
    end

    example_request 'Update account (valid)' do
      expect(status).to eq 200
    end

    example 'Update account (invalid)' do
      do_request(account: {current_password: 'incorrect'})
      expect(status).to eq 422
    end
  end
end
