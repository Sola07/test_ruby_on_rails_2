class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :starting_date
      t.date :ending_date
      t.string :starting_time
      t.string :ending_time
      t.integer :key
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
