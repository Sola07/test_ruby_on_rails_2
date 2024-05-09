class ImportedFilesController < ApplicationController
  require_relative "../services/file_import_service.rb"

  def index;end

  def import
    file = params[:file]
    imported_file = ImportedFile.create(file_name: file.original_filename, file_type: file.original_filename.split(".")[1])
    service = "#{imported_file.file_type.capitalize}ImportService"
    service.constantize.call(file, imported_file.id)
    redirect_to root_path(imported_file_id: imported_file.id), notice: "File imported successfully."
  end

  def show
    @imported_file = ImportedFile.find(params[:id])
    @events = @imported_file.events
  end
end
