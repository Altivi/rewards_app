class Session < ApplicationRecord
  SESSION_LIFE_TIME = 1.month
  enum device_platform: %i[web]
  
  belongs_to :account
  
  validates :device_platform, presence: true

  after_create :destroy_previous_device_sessions, if: -> { device_token }
  
  has_secure_token :access_token

  scope :not_expired, -> { where('updated_at > ?', Time.current - SESSION_LIFE_TIME) }
  
  private

  def destroy_previous_device_sessions
    Session.where.not(id: id).where(device_token: device_token).destroy_all
  end
end
