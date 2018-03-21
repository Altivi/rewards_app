class Session < ApplicationRecord
  SESSION_LIFE_TIME = 1.month
  enum device_platform: %i[ios android]
  
  belongs_to :account
  
  after_create :destroy_previous_device_sessions
  
  scope :not_expired, -> { where('updated_at > ?', Time.current - SESSION_LIFE_TIME) }
  
  private

  def destroy_previous_device_sessions
    Session.where.not(id: id).where(device_token: device_token).destroy_all if device_token
  end
end
