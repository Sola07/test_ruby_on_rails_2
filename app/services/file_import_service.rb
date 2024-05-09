class FileImportService
  def self.call(...)
    new.call(...)
  end

  private

  def process_row(row, imported_file_id)
    purchaser = Purchasers::CreateService.call(row)
    show = Shows::CreateService.call(row, imported_file_id)
    pricing = Pricings::CreateService.call(row)
    event = Events::CreateService.call(row, show, imported_file_id)
    Bookings::CreateService.call(row, event, pricing, show, purchaser, imported_file_id)
  end
end
