class CreateFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :followers do |t|
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
