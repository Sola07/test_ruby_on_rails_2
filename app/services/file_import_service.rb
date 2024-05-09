class FileImportService
require 'csv'
require 'creek'

  def self.call(...)
    new.call(...)
  end

  private

  def process_row(row, imported_file_id)
    purchaser = Purchasers::CreateService.new(row).call
    show = Shows::CreateService.new(row, imported_file_id).call
    pricing = Pricings::CreateService.new(row).call
    event = Events::CreateService.new(row, show, imported_file_id).call
    Bookings::CreateService.new(row, event, pricing, show, purchaser, imported_file_id).call
  end
end
