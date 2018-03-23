FactoryBot.define do
  factory :reward do
    status { Reward.statuses.keys.sample }
    association :account, factory: [:account, :with_session]
  end
end
