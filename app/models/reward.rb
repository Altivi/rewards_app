class Reward < ApplicationRecord
  enum status: %i[
    waiting_to_be_approved approved 
    denied sent redeemed completed
  ]

  belongs_to :account

  validates :status, presence: true

  scope :status, -> (status) { where(status: status) if status }
end
