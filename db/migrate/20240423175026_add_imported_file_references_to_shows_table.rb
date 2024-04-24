class AddImportedFileReferencesToShowsTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :shows, :imported_file, index: true
  end
end
