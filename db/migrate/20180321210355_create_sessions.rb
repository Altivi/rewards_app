class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.references :account, foreign_key: true
      t.string :access_token, index: true
      t.string :device_token
      t.integer :device_platform

      t.timestamps
    end
  end
end
