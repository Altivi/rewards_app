class AccountsController < ApplicationController
  def index
    @rewards = current_account.rewards.status(filter_params).page(params[:page])
  end

  private

  def filter_params
    Reward.statuses[@filter = params.permit(:filter)[:filter]]
  end
end
