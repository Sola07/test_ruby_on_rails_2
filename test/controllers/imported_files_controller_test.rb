require "test_helper"

class ImportedFilesControllerTest < ActionDispatch::IntegrationTest
  test "imports CSV file and increments database records" do
    csv_file = fixture_file_upload('test/fixtures/files/test.csv', 'text/csv')

    initial_imported_file_count = ImportedFile.count
    initial_purchaser_count = Purchaser.count
    initial_show_count = Show.count
    initial_pricing_count = Pricing.count
    initial_event_count = Event.count
    initial_booking_count = Booking.count

    post import_imported_files_path, params: { file: csv_file }

    assert_equal initial_imported_file_count + 1, ImportedFile.count
    assert_equal initial_purchaser_count + 24, Purchaser.count
    assert_equal initial_show_count + 25, Show.count
    assert_equal initial_pricing_count + 99, Pricing.count
    assert_equal initial_event_count + 40, Event.count
    assert_equal initial_booking_count + 99, Booking.count

    assert_redirected_to root_path(imported_file_id: ImportedFile.last.id)
    assert_equal "File imported successfully.", flash[:notice]
  end

  test "imports xlsx file and increments database records" do
    xlsx_file = fixture_file_upload('test/fixtures/files/test.xlsx', '.xlsx')

    initial_imported_file_count = ImportedFile.count
    initial_purchaser_count = Purchaser.count
    initial_show_count = Show.count
    initial_pricing_count = Pricing.count
    initial_event_count = Event.count
    initial_booking_count = Booking.count

    post import_imported_files_path, params: { file: xlsx_file }

    assert_equal initial_imported_file_count + 1, ImportedFile.count
    assert_equal initial_purchaser_count + 24, Purchaser.count
    assert_equal initial_show_count + 25, Show.count
    assert_equal initial_pricing_count + 99, Pricing.count
    assert_equal initial_event_count + 40, Event.count
    assert_equal initial_booking_count + 99, Booking.count

    assert_redirected_to root_path(imported_file_id: ImportedFile.last.id)
    assert_equal "File imported successfully.", flash[:notice]
  end

end
