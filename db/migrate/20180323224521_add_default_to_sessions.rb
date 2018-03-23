class AddDefaultToSessions < ActiveRecord::Migration[5.1]
  def change
    change_column_default :sessions, :device_platform, from: nil, to: 0
  end
end
