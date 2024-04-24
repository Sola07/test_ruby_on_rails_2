module Bookings
  class CreateService
    def initialize(params, event, pricing, show, purchaser, imported_file)
      @params = params
      @event = event
      @pricing = pricing
      @show = show
      @purchaser = purchaser
      @imported_file = imported_file
    end

    def call
      booking.save!
      return booking
    end

    private
    attr_reader :params, :event, :pricing, :show, :purchaser, :imported_file

    def booking
      @booking||= Booking.create(
        number: params["Reservation"],
        date: Date.strptime(params["Date reservation"], '%d/%m/%y'),
        time: params["Heure reservation"],
        ticket_number: params["Numero billet"],
        sales_channel: params["Filiere de vente"],
        event_id: @event.id ,
        pricing_id: @pricing.id,
        purchaser_id: @purchaser.id,
        show_id: @show.id,
        imported_file: @imported_file
      )
    end
  end
end
