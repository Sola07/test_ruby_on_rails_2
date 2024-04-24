require "test_helper"

class ImportedFilesControllerTest < ActionDispatch::IntegrationTest
  test "imports CSV file and increments database records" do
    # Utilisez un objet ActionDispatch::Http::UploadedFile simulé avec les données CSV
    csv_file = fixture_file_upload('test/fixtures/files/test.csv', 'text/csv')

    # Comptez le nombre d'enregistrements dans chaque modèle avant l'importation
    initial_imported_file_count = ImportedFile.count
    initial_purchaser_count = Purchaser.count
    initial_show_count = Show.count
    initial_pricing_count = Pricing.count
    initial_event_count = Event.count
    initial_booking_count = Booking.count

    # Effectuez une demande POST avec le fichier CSV simulé
    post import_imported_files_path, params: { file: csv_file }

    # Vérifiez que le fichier CSV a été importé avec succès et que la base de données a été incrémentée de X enregistrements
    assert_equal initial_imported_file_count + 1, ImportedFile.count
    assert_equal initial_purchaser_count + 24, Purchaser.count
    assert_equal initial_show_count + 25, Show.count
    assert_equal initial_pricing_count + 99, Pricing.count
    assert_equal initial_event_count + 40, Event.count
    assert_equal initial_booking_count + 99, Booking.count

    # Vérifiez d'autres éléments nécessaires à votre fonctionnalité d'importation

    # Vérifiez la redirection ou la réponse appropriée après l'importation réussie
    assert_redirected_to root_path(csv_file.id)
    assert_equal "CSV imported successfully.", flash[:notice]
  end
end
