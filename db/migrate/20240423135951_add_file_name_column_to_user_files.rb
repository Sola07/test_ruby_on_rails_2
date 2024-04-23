class AddFileNameColumnToUserFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_files, :file_name, :string
  end
end
