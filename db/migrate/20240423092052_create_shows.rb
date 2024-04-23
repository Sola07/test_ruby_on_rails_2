class CreateShows < ActiveRecord::Migration[7.1]
  def change
    create_table :shows do |t|
      t.integer :key
      t.string :name

      t.timestamps
    end
  end
end
