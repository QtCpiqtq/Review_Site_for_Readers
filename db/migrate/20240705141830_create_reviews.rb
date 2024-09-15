class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false
      t.text :body, null: false
      t.float :evolution, null: false
      t.integer :feeling_after_reading_id

      t.timestamps
    end
  end
end
