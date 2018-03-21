class Account < ApplicationRecord
  has_many :rewards

  devise :database_authenticatable, :rememberable, :validatable
end
