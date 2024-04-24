class FileImportService
require 'csv'
require 'creek'

  def call(file, imported_file_id)
    if File.extname(file) == ".csv"
      parse_csv(file, imported_file_id)
    elsif File.extname(file) == ".xlsx"
      parse_xlsx(file, imported_file_id)
    else
      raise ArgumentError, "Unsupported file format"
    end
  end

  private

  def parse_csv(file, imported_file_id)
    CSV.foreach(file, headers: true, col_sep: ";") do |row|
      process_row(row, imported_file_id)
    end
  end

  def parse_xlsx(file, imported_file_id)
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

  def process_row(row, imported_file_id)
    purchaser = Purchasers::CreateService.new(row).call
    show = Shows::CreateService.new(row, imported_file_id).call
    pricing = Pricings::CreateService.new(row).call
    event = Events::CreateService.new(row, show, imported_file_id).call
    booking = Bookings::CreateService.new(row, event, pricing, show, purchaser, imported_file_id).call
  end
end
