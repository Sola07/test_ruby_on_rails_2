class CsvImportService
  require "csv"
  def call(file, imported_file)
    file = File.new(file)
    CSV.foreach(file, headers: true, col_sep: ";") do |row|
      purchaser = Purchasers::CreateService.new(row).call
      show = Shows::CreateService.new(row, imported_file).call
      pricing = Pricings::CreateService.new(row).call
      event = Events::CreateService.new(row, show).call
      booking = Bookings::CreateService.new(row, event, pricing, show, purchaser, imported_file).call
    end
  end
end
