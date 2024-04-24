class AddTypeToImportedFile < ActiveRecord::Migration[7.1]
  def change
    add_column :imported_files, :type, :string
  end
end
