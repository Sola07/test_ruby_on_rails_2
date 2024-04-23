class PagesController < ApplicationController
  def home
  end

  def import
    file = params[:file]
    redirect_to root_path, notice: "only csv please" unless file.content_type == "text/csv"

    #call the import service to parse the file and import data in the database
    CsvImportService.new.call(file)
  end
end
