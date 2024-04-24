class AddImportedFilesReferencesToBookingTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :imported_file, foreign_key: true
  end
end
