class AddImportedFileReferencesToEventsTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :imported_file, index: true
  end
end
