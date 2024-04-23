class AddUserFileReferencesToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :user_file, index: true
  end
end
