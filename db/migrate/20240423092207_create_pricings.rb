class CreatePricings < ActiveRecord::Migration[7.1]
  def change
    create_table :pricings do |t|
      t.float :amount
      t.string :product_type

      t.timestamps
    end
  end
end
