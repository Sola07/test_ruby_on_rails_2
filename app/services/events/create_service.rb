module Events
  class CreateService < ApplicationService
    def initialize(params, show, imported_file_id)
      @params = params
      @show = show
      @imported_file_id = imported_file_id
    end

    def call
      event.save!
      return event
    end

    private
    attr_reader :params, :show, :imported_file_id

    def event
      @event||= find_or_create_event
    end

    def find_or_create_event
      event = ::Event.find_or_initialize_by(key: params["Cle representation"], imported_file_id: imported_file_id) do |new_event|
        new_event.name = params["Representation"]
        new_event.starting_date = Date.strptime(params["Date representation"], '%d/%m/%y')
        new_event.ending_date = Date.strptime(params["Date fin representation"], '%d/%m/%y')
        new_event.starting_time =  params["Heure representation"]
        new_event.ending_time = params["Heure fin representation"]
        new_event.key = params["Cle representation"]
        new_event.show_id = show.id
        new_event.imported_file_id = imported_file_id
      end
      event
    end
  end
end
