class RemoveUserFileReferencesToBookingsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :user_file_id
  end
end
