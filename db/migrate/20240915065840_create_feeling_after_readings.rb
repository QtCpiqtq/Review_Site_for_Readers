class CreateFeelingAfterReadings < ActiveRecord::Migration[6.1]
  def change
    create_table :feeling_after_readings do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
