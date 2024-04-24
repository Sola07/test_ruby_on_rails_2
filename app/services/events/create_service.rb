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
      Event.find_or_create_by(
        name: params["Representation"],
        starting_date: Date.strptime(params["Date representation"], '%d/%m/%y'),
        ending_date: Date.strptime(params["Date fin representation"], '%d/%m/%y'),
        starting_time:  params["Heure representation"],
        ending_time: params["Heure fin representation"],
        key: params["Cle representation"],
        show_id: @show.id
      )
    end
  end
end
