class CsvImportService
  require "csv"
# parse csv file & create new instances of purchaser, show, pricing, event, and booking
  def call(file, user_file)
    file = File.new(file)
    csv = CSV.parse(file, headers: true, col_sep: ";")
    CSV.foreach(file, headers: true, col_sep: ";") do |row|

      purchaser = Purchaser.find_or_create_by(
        last_name: row["Nom"],
        first_name: row["Prenom"],
        email: row["Email"],
        address: row["Adresse"],
        zipcode: row["Code postal"],
        country: row["Pays"],
        age: row["Age"],
        gender: row["Sexe"]
      )

      show = Show.find_or_create_by(
        key: row["Cle spectacle"],
        name: row["Spectacle"]
      )

      pricing = Pricing.create(
        amount: row["Prix"],
        product_type: row["Type de produit"]
      )

      event = Event.find_or_create_by(
        name: row["Representation"],
        starting_date: Date.strptime(row["Date representation"], '%d/%m/%y'),
        ending_date: Date.strptime(row["Date fin representation"], '%d/%m/%y'),
        starting_time:  row["Heure representation"],
        ending_time: row["Heure fin representation"],
        key: row["Cle representation"],
        show_id: show.id
      )

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
        user_file_id: user_file.id
      )

    end
  end
end
