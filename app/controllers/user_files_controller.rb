class UserFilesController < ApplicationController
  require_relative "../services/csv_import_service.rb"

  def index
  end


  def import
    file = params[:file]
    redirect_to root_path, notice: "only csv please" unless file.content_type == "text/csv"
    user_file = UserFile.create(file_name: file.original_filename)

    #call the import service to parse the file and import data in the database
    CsvImportService.new.call(file, user_file)
    redirect_to root_path(user_file_id: user_file.id), notice: "CSV imported successfully."
  end
end
