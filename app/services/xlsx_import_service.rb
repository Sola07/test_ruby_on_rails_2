class XlsxImportService < FileImportService
require 'creek'

  def call(file, imported_file_id)
    creek = Creek::Book.new(file)
    worksheet = creek.sheets[0]
    header_row = worksheet.rows.first
    header_values = header_row["A1"].split(";")
    i = 2
    worksheet.rows.drop(1).each do |row|
      row_values = row["A#{i}"].split(";")
      row_data = Hash[header_values.zip(row_values)]
      process_row(row_data, imported_file_id)
      i += 1
    end
  end
end
