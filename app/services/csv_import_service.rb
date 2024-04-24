class CsvImportService
  require "csv"
# parse csv file & create new instances of purchaser, show, pricing, event, and booking
  def call(file, imported_file)
    file = File.new(file)
    CSV.foreach(file, headers: true, col_sep: ";") do |row|
      purchaser = create_purchaser(row)
      show = create_show(row, imported_file)
      pricing = create_pricing(row)
      event = create_event(row, show)
      booking = create_booking(row, event, pricing, show, purchaser, imported_file)
    end
  end

  private

  def create_purchaser(row)
    Purchaser.find_or_create_by(
        last_name: row["Nom"],
        first_name: row["Prenom"],
        email: row["Email"],
        address: row["Adresse"],
        zipcode: row["Code postal"],
        country: row["Pays"],
        age: row["Age"],
        gender: row["Sexe"]
      )
  end

  def create_show(row, imported_file)
    Show.find_or_create_by(
          key: row["Cle spectacle"],
          name: row["Spectacle"],
          imported_file_id: imported_file.id
        )
  end

  def create_pricing(row)
    Pricing.create(
        amount: row["Prix"],
        product_type: row["Type de produit"]
      )
  end

  def create_event(row, show)
    Event.find_or_create_by(
        name: row["Representation"],
        starting_date: Date.strptime(row["Date representation"], '%d/%m/%y'),
        ending_date: Date.strptime(row["Date fin representation"], '%d/%m/%y'),
        starting_time:  row["Heure representation"],
        ending_time: row["Heure fin representation"],
        key: row["Cle representation"],
        show_id: show.id
      )
  end

  def create_booking(row, event, pricing, show, purchaser, imported_file)
    Booking.create(
        number: row["Reservation"],
        date: Date.strptime(row["Date reservation"], '%d/%m/%y'),
        time: row["Heure reservation"],
        ticket_number: row["Numero billet"],
        sales_channel: row["Filiere de vente"],
        event_id: event.id ,
        pricing_id: pricing.id,
        purchaser_id: purchaser.id,
        show_id: show.id,
        imported_file: imported_file
      )
  end
end
