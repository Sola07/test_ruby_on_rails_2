class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer :number
      t.date :date
      t.string :time
      t.integer :ticket_number
      t.string :sales_channel
      t.references :event, null: false, foreign_key: true
      t.references :pricing, null: false, foreign_key: true
      t.references :purchaser, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
