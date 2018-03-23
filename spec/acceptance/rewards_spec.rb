require "acceptance_helper"

resource "Rewards", acceptance: :request do
  let(:account) { create(:account, :with_session) }
  let(:session) { account.sessions.take }
  
  get "/api/v1/rewards" do
    let!(:rewards) { create_list :reward, 200, account: account }
    let!(:page) { 1 }
    let!(:filter) { 'approved' }
    before { header 'Access-Token', session.access_token }

    parameter :filter, 'Filter by status (waiting_to_be_approved, approved, denied, sent, redeemed, completed)'
    parameter :page, 'Page for pagination'

    example_request 'Get all rewards' do
      expect(status).to eq 200
    end
  end
end
