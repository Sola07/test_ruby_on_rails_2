module Bookings
  class CreateService < ApplicationService
    def initialize(params, event, pricing, show, purchaser, imported_file_id)
      @params = params
      @event = event
      @pricing = pricing
      @show = show
      @purchaser = purchaser
      @imported_file_id = imported_file_id
    end

    def call
      booking.save!
      return booking
    end

    private
    attr_reader :params, :event, :pricing, :show, :purchaser, :imported_file_id

    def booking
      @booking||= Booking.new(
        number: params["Reservation"],
        date: Date.strptime(params["Date reservation"], '%d/%m/%y'),
        time: params["Heure reservation"],
        ticket_number: params["Numero billet"],
        sales_channel: params["Filiere de vente"],
        event_id: event.id ,
        pricing_id: pricing.id,
        purchaser_id: purchaser.id,
        show_id: show.id,
        imported_file_id: imported_file_id
      )
    end
  end
end
