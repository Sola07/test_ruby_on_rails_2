class ImportedFilesController < ApplicationController
  require_relative "../services/csv_import_service.rb"

  def index;end

  def import
    file = params[:file]
    if file.blank? || file.content_type != "text/csv"
      flash[:alert] = "Please upload a CSV file."
      redirect_to root_path
      return
    end

    imported_file = ImportedFile.create(file_name: file.original_filename)

    #call the import service to parse the file and import data in the database
    CsvImportService.new.call(file, imported_file)
    redirect_to root_path(imported_file_id: imported_file.id), notice: "CSV imported successfully."
  end

  def show
    @imported_file = ImportedFile.find(params[:id])
    @events = @imported_file.events
  end
end
