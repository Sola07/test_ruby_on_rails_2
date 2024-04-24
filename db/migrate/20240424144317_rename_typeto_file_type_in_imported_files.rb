class RenameTypetoFileTypeInImportedFiles < ActiveRecord::Migration[7.1]
  def change
    rename_column :imported_files, :type, :file_type
  end
end
