class CreatePurchasers < ActiveRecord::Migration[7.1]
  def change
    create_table :purchasers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.integer :zipcode
      t.string :country
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end
