json.rewards do
  json.array! @rewards do |reward|
    json.partial! "api/v1/rewards/reward", reward: reward
  end
end

json.partial! 'api/v1/shared/pagination', collection: @rewards