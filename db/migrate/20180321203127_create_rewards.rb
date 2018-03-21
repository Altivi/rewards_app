class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.references :account, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
