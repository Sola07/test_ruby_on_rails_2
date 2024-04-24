class ImportedFilesController < ApplicationController
  require_relative "../services/file_import_service.rb"

  def index;end

  def import
    file = params[:file]
    imported_file = ImportedFile.create(file_name: file.original_filename)
    FileImportService.new.call(file, imported_file.id)
    redirect_to root_path(imported_file_id: imported_file.id), notice: "CSV imported successfully."
  end

  def show
    @imported_file = ImportedFile.find(params[:id])
    @events = @imported_file.events
  end
end
