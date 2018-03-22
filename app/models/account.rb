class Account < ApplicationRecord
  has_many :rewards, dependent: :destroy
  has_many :sessions, dependent: :destroy

  validates :name, presence: true

  devise :database_authenticatable, :rememberable, :validatable
end
