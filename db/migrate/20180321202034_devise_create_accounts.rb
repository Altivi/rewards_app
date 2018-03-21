# frozen_string_literal: true

class DeviseCreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.datetime :remember_created_at
      t.timestamps null: false
    end

    add_index :accounts, :email,                unique: true
  end
end
