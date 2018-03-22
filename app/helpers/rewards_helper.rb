module RewardsHelper
  def rewards_options
    Reward.statuses.keys.to_a
  end
end
