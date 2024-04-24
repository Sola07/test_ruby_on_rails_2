class RenameUserFiletoImportedFileTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :user_files, :imported_files
  end
end
