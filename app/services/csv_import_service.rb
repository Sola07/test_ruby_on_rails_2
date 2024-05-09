class CsvImportService < FileImportService
  require "csv"

  def call(file, imported_file_id)
    CSV.foreach(file, headers: true, col_sep: ";") do |row|
      process_row(row, imported_file_id)
    end
  end

end
