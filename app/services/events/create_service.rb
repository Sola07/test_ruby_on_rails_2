module Events
  class CreateService
    def initialize(params, show)
      @params = params
      @show = show
    end

    def call
      event.save!
      return event
    end

    private
    attr_reader :params, :show

    def event
      @event||= find_or_create_event
    end

    def find_or_create_event
      event = ::Event.find_or_initialize_by(key: params["Cle representation"]) do |new_event|
        new_event.name = params["Representation"]
        new_event.starting_date = Date.strptime(params["Date representation"], '%d/%m/%y')
        new_event.ending_date = Date.strptime(params["Date fin representation"], '%d/%m/%y')
        new_event.starting_time =  params["Heure representation"]
        new_event.ending_time = params["Heure fin representation"]
        new_event.key = params["Cle representation"]
        new_event.show_id = @show.id
      end
      event
    end
  end
end
